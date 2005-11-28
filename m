From: "Li Weichen" <iaadoa@gmail.com>
Subject: RE: Basic question: how to flash omap system with ccs?
Date: Mon, 28 Nov 2005 20:29:26 +0800
Message-ID: <438af835.547cd4ee.1b00.4646@mx.gmail.com>
References: <Pine.LNX.4.63.0511272306080.21860@pcy.artec.ee>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <Pine.LNX.4.63.0511272306080.21860@pcy.artec.ee>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Olav Kongas' <ok@artecdesign.ee>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Olav,

It is so kind of to reply.  I am very interested about your COFF generator.
Would you please share it?  And could you give me some instructions showing
the operating process if not so bother?

Thanks again.

Best regards!


Li Weichen
2005-11-28

> -----Original Message-----
> From: Olav Kongas [mailto:ok@artecdesign.ee]
> Sent: Monday, November 28, 2005 5:55 AM
> To: Li Weichen
> Cc: linux-omap-open-source@linux.omap.com
> Subject: Re: Basic question: how to flash omap system with ccs?
> 
> 
> 
> On Sun, 27 Nov 2005, Li Weichen wrote:
> 
> > Hi all,
> >
> > I have an TI XDS560 emulator and CCS 3.1 by hand.  Can I load the
> > bootloader, kernel and file system with them?  I have never used CCS
before,
> > so I eagerly hope someone could show me the steps or where I can find
the
> > answer.
> 
> I'm right now working on the same problem. I'm using XDS510
> if that matters. The aim is to transfer u-boot to omap5912's
> SRAM and then burn it into the virgin onboard flash of our
> custom board. I plan to transfer kernel and the rest later
> when already booted up from u-boot.
> 
> Initially I started to modify u-boot so that it could run in
> SRAM, with jtag connected, so that I could use u-boot
> functionality to burn itself into flash. However, it turned
> out more and more changes to u-boot were needed so I decided
> to whip up a little custom flash programmer for that.
> 
> The scheme is the following: the u-boot image will be
> appended to the flash programmer image, the result will be
> converted to the TI's COFF format and transferred from CCS
> over jtag to omap's SRAM, where the programmer will be
> started.
> 
> I have CCS and jtag emulator working. I really recommend to
> carefully read the instructions at Spectrum Digital's
> webpage on how to set it all correctly up. I have written a
> little COFF header generator to convert raw images into TI's
> COFF; that's the format the CCS agrees to load over jtag. If
> you want the tool just let me know. Currently I am working
> on the flash programmer.
> 
> Olav
