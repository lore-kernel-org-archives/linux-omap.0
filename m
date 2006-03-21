From: David Cohen <david.cohen@indt.org.br>
Subject: Re: [PATCH] Re: omap24xxcam status (Was: v4l2 camera test app)
Date: Tue, 21 Mar 2006 09:23:28 -0400
Message-ID: <441FFE50.90501@indt.org.br>
References: <20060321125638.26538.qmail@web32913.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20060321125638.26538.qmail@web32913.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: ext Komal Shah <komal_shah802003@yahoo.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

This kind of error probably has ocurred because a dma transferring was
droped when you pressed ctrl+c. It will not affect anything, but it is
good to avoid messages like that in future patches.

Regards,

David Cohen

ext Komal Shah wrote:
> --- David Cohen <david.cohen@indt.org.br> wrote:
>
>   
>> Hi,
>>
>> I am sending a new patch with support for the new sensor interface
>> (kernel 2.6.10 TI already did it). I have made also some updates
>> according to Komal comments. :)
>>
>>     
>
> Thanx. I have tested it with H4 now, after updating sensor_ov9640.c
> with common registers settings for h4 and changing to new sensor
> interface.
>
> I am able to capture and preview qvga and vga. But using my earlier
> test application vcam.c to preview, if I press ctrl-c to exit that
> preview while (1) loop, it gives following overlay callback csr error.
> Sorry, not spent much time to investigate the cause of this error.
>
> log: 
>
> # ./vcapture -d /dev/video0 -p
> device name is /dev/video0
> v4l2: init
> v4l2: device info:
>   omap24xxcam 0.0.0 / omap24xxcam @
> v4l2: new params (320x240, UYVY, 153600 byte)
>
> <Press Ctrl-C>
>
> # 
> omap24xxcam: overlay_callback error. csr = 0x00000020
> omap24xxcam: overlay_callback error. csr = 0x00000020
>
>
> ---Komal Shah
> http://komalshah.blogspot.com/
>
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com 
>   
