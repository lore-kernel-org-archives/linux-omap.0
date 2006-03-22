From: "Jayasimha" <jsimha@sasken.com>
Subject: Re: Runtime profiling of DSP Code
Date: Wed, 22 Mar 2006 16:07:32 +0530
Message-ID: <063701c64d9c$a06246f0$5d52000a@sasken.com>
References: <20060322101355.26859.qmail@web8410.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
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
To: prakhar vig <aquarian_133@yahoo.co.in>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


you can use clock() function to do it. 
clock() - gives no of cpu clocks elapsed since its last call.
include time.h

--
JS

----- Original Message ----- 
From: "prakhar vig" <aquarian_133@yahoo.co.in>
To: <linux-omap-open-source@linux.omap.com>
Sent: Wednesday, March 22, 2006 3:43 PM
Subject: Runtime profiling of DSP Code


> Hi All,
> 
> I am working on 1610 H2 Board.
> Can anyone tell me how to do the runtime profiling of
> the DSP code without using the JTAG emulator.
> Actually I want to see the number of milliseconds took
> by my decoder and want to see it on console. Please
> guide me for the same.
> 
> Thanks And Regards
> Prakhar
> 
> 
> 
> ____________________________________________________
> Jiyo cricket on Yahoo! India cricket 
> http://in.sports.yahoo.com/cricket/
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 


"SASKEN RATED Among THE Top 3 BEST COMPANIES TO WORK FOR IN INDIA - SURVEY 2005 conducted by the BUSINESS TODAY - Mercer - TNS India"

                           SASKEN BUSINESS DISCLAIMER
This message may contain confidential, proprietary or legally Privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, Disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email
