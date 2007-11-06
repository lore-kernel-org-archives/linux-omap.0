From: Steve Poulsen <spoulsen@css-design.us>
Subject: OMAP USB - ISO data_flush errors not handled? (OMAP 5912)
Date: Mon, 05 Nov 2007 20:37:11 -0600
Message-ID: <472FD357.4000707@css-design.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I have run into an issue where the ISO audio (OUT) will enter a state 
where it stops playing.  This problem occurs if a single packet is 
missed (1 ms).  What happens is the OMAP 5912 reports a DATA_FLUSH 
error, as expected, but it never clears.  As I understand this error 
condition, it occurs during the next good frame and lasts during that 
frame.  In other words, when the error condition occurs, it indicates 
that the previous frame was overwritten before it was processed.

Please refer to omap_udc.c, function omap_udc_iso_irq:

            else if (stat & UDC_DATA_FLUSH)
                status = -ENOSR;

            if (status)
            {
                /* done(ep, req, status) */;
            }
            else
                read_fifo(ep, req);

It is my believe that "read_fifo" should still be called for the 
UDC_DATA_FLUSH condition.  I have tested and it does solve my problem.  
Please confirm.

The problem can be reproduced by adding a delay() of more than 1 ms in 
the read_completion for this usb_request.  The 1 ms delay should be 
added just one time, and not continuously.  It would be expected that 
the single audio frame is lost and not all audio frames thereafter.

Steve
