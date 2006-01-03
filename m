From: Jose Manuel Cano Garcia <jcgarcia@uma.es>
Subject: Re: USB problem in 2.6.14.5
Date: Tue, 03 Jan 2006 11:52:03 +0100
Message-ID: <43BA5753.5050704@uma.es>
References: <20060102104036Z4334330-19345+1244@kps4.test.onet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060102104036Z4334330-19345+1244@kps4.test.onet.pl>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: janiszo@poczta.onet.pl
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

If you are using a OSK5912 board, please read the thread "OSK5912 USB 
Port Problem" in this mailing list (November 2005) (I am not sure if the 
problem also exists for other boards). An additional patch is needed for 
kernel from 2.6.12 to 2.6.15 to get USB host working. Alternatively, you 
can disable the RESET_UNUSED_CLOCK feature.

This is the patch:

http://linux.omap.com/pipermail/linux-omap-open-source/2005-August/004818.html 


See also the following mail on this list:

http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/006030.html

Best regards,

Jose

janiszo@poczta.onet.pl wrote:

>Hi,
>Are there any changes in kernel 2.6.14 against 2.6.11 with USB support? I compiled new kernel with the same options as in the old one and system cannot see USB devices now. There is no /proc/bus/usb folder at all, while during startup mesaages about usbco
>re/ohci/mass storage registering appear.
>I'm, using kernel 2.6.14.5 with patch-2.6.14-omap2.
>
>Jack 
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>.
>
>  
>
