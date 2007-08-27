From: "Amit Gupta" <amitjobs05@gmail.com>
Subject: Re: USB Function Driver code for OMAP 2430 SDP
Date: Tue, 28 Aug 2007 01:55:17 +0530
Message-ID: <78d6ed630708271325m400b0763off44093485d38057@mail.gmail.com>
References: <20070827142801.F1C9BCA0A4@ws5-11.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070827142801.F1C9BCA0A4@ws5-11.us4.outblaze.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kanagesh R <kanagesh@india.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Kanagesh

Congrats, Its really nice that your USB function driver code is working.

Well this has given me more hopes :)

To tell you:-

1. I am using the
linux.omap.com/pub/kernel/2430sdp/source/linux-2.6.14-omap2-v3.tgz
source code for my kernel building. (The same has been used by you, so
this does ot seems to be problem). You have not taken any patches
above this code ?

2. I am using the OMAP 2430 SDP 4.0, I am not sure about version 4.01.
but there should not be much of difference in them.

3. I am doing switch setting S6-6 , S6-7, S6-2 ON.

So the only problem might be with the config file ? Can you send me
your config file ( and tell me if you include the OTG components ?).

Also how did you know, that Function Driver is working ? Dis you got
OMAP_UDC interrupts(IRQ - 75)  and ISP1301 interrupts ? And how was
the response on the Host (Desktop) side ? Did you also downloaded any
driver on the host side for proper enumeration ?

And I hope you did not modified the code in any way. Kindly confirm
the same by the earliest so that thingss work at my end also.

Thanks & Regards

Amit Gupta



On 8/27/07, Kanagesh R <kanagesh@india.com> wrote:
>
> > ----- Original Message -----
> > From: "Amit Gupta" <amit_jobs05@inbox.com>
> > To: "Linux OMAP" <linux-omap-open-source@linux.omap.com>
> > Subject: USB Function Driver code for OMAP 2430 SDP
> > Date: Sat, 25 Aug 2007 02:28:38 +0530
> >
> >
> > This is in continuation of the previous mail as below
> >
> > Are there any patches for the FSUSB function controller on OMAP2430
> > SDPv4.0 since the code available in the public folder does not seem to
> > work.
> >
>
> Hello Everyone,
>
> I have finally been able to get USB gadget working on my OMAP2430 SDP board last week.  I guess it has been working well all the time with the kernel that I am using - I was not setting the DIP switch settings on the SDP board to the right configurations to allow it to work on my board.
>
> I had mentioned the DIP switch settings to be a concern on one of my mails and I received a reply saying that two DIP switches - switches 6 (HSUSB_nFS) and 7 (HSVBUS_nFS) in S6 - had to be set to the 'ON' position.  I later learnt that switch 2 (USB_nDB9) in S6 needed to be set to the 'ON' position aswell.  With all these switches set to the 'ON' position, plugging in the USB cable to connector J51 (through ISP1301 transceiver) made things work like a charm!
>
> I am now able to establish a TCP/IP link between the OMAP2430 SDP board and a Windows XP system through ethernet over USB.  I have done some basic testing on the link by making transfers to and from both sides using FTP.
>
> In short, this is what I have:
>
> Board  : OMAP2430 SDP version V4.01
> Kernel : linux.omap.com/pub/kernel/2430sdp/source/linux-2.6.14-omap2-v3.tgz
> DIP Switch setting: Switches 2 (USB_nDB9), 6(HSUSB_nFS) and 7()HSVBUS_nFS) in switch S6 set to position 'ON'
> Toolchain: ARM toolchain with EABI support from www.codesourcery.com
>
> Hope this helps!  Thank you very much to everyone who had their valuable inputs when I needed it.
>
> Regards,
> Kanagesh
>
>
>
> =
> $3,500 - $7,000 Per Week
> Must Be Ready To Start Immediately Great pay! Start Today.
> http://a8-asy.a8ww.net/a8-ads/adftrclick?redirectid=9a9ddf1ba5d75a756383e82bf64670d8
>
>
> --
> _______________________________________________
> Search for products and services at:
> http://search.mail.com
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
