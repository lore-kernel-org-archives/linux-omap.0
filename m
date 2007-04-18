From: "Kyungmin Park" <kmpark@infradead.org>
Subject: RE: One NAND Booting
Date: Wed, 18 Apr 2007 09:24:28 +0900
Message-ID: <000001c7814f$f1ff0510$e1ac580a@swcenter.sec.samsung.co.kr>
References: <3B6D69C3A9EBCA4BA5DA60D913027429C8DCB4@dlee13.ent.ti.com>
	<42E999AD7A0E4647BF159F467EE4FBCBE649FF@BLR-SGM-MSG01.wipro.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429C8DD96@dlee13.ent.ti.com>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <3B6D69C3A9EBCA4BA5DA60D913027429C8DD96@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "'Woodruff, Richard'" <r-woodruff2@ti.com>, sathish.madhava@wipro.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

If you want to boot with OneNAND without other tools such as CSST(?), you can do
it.

You should make a 1KB xloader binary by only initialize the SDRAM in xloader.
The others are done by the second bootloader such as U-Boot.

Now the apollon board based on OMAP2420 boots with this method. Note that it is
not yet tested with omap2430sdp. But I think it's working.

+-----------+-----------+-------------------------------------+
| xloader | dummy | U-boot < (128KB - 2KB)  |
+-----------+-----------+-------------------------------------+
   1KB        1KB

The xloader only does following things.

1. cpu1136 initialization
2. SDRAM initialization (SDRC)
3. copy U-boot to RAM
4. jump to U-boot

Note; you never runs SDRAM initialization in U-boot. it will be hang.

Please refer to this URL.
http://source.mvista.com/git/gitweb.cgi?p=xloader.git;a=summary 

Thank you,
Kyungmin Park

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com 
> [mailto:linux-omap-open-source-bounces@linux.omap.com] On 
> Behalf Of Woodruff, Richard
> Sent: Wednesday, April 18, 2007 2:01 AM
> To: sathish.madhava@wipro.com; linux-omap-open-source@linux.omap.com
> Subject: RE: One NAND Booting
> 
> Look at the archive for this group.
> 
>  
> 
> I posted the exact steps for burning into OneNAND such that it boots.
> If you follow those you will boot on the SDP as I can today.
> 
>  
> 
> You are free to create another method if you must, but it doesn't seem
> necessary.
> 
>  
> 
> Regards,
> 
> Richard W.
> 
>  
> 
> ________________________________
> 
> From: sathish.madhava@wipro.com [mailto:sathish.madhava@wipro.com] 
> Sent: Tuesday, April 17, 2007 11:09 AM
> To: Woodruff, Richard; linux-omap-open-source@linux.omap.com
> Subject: RE: One NAND Booting
> 
>  
> 
> Hi,
> 
> My requirement is to use entirely OneNAND and not to use NAND.,
> 
> if thats the case how do i fit the X-loader code in 1KB of OneNAND
> BootRAM area.
> 
>  
> 
> -Sathish
> 
> ________________________________
> 
> From: Woodruff, Richard [mailto:r-woodruff2@ti.com]
> Sent: Tue 4/17/2007 8:55 PM
> To: Sathish kumar tekal Sethu madhava rao (WT01 - Wireless 
> Networks and
> Devices); linux-omap-open-source@linux.omap.com
> Subject: RE: One NAND Booting
> 
> > I am trying to do One NAND Booting on OMAP2430sdp.
> > I found that I need to have X-loader image which fits in 1KB
> > of Boot RAM.
> > Currently the X-loader code i have is around 6KB, can
> > somebody suggest where to get this 1KB size X-loader Code.
> 
> You likely don't need this.  The xloading on the TI site can already
> boot from OneNAND on the 2430sdp.
> 
> Mask ROM code runs and loads code from NAND into SRAM to be executed.
> You are limited by your SRAM space (as used by the mask ROM) and block
> size of the flash device not the XIP space in the OneNAND.
> 
> Regards,
> Richard W.
> 
> 
> The information contained in this electronic message and any 
> attachments
> to this message are intended for the exclusive use of the addressee(s)
> and may contain proprietary, confidential or privileged 
> information. If
> you are not the intended recipient, you should not disseminate,
> distribute or copy this e-mail. Please notify the sender 
> immediately and
> destroy all copies of this message and any attachments. 
> 
> WARNING: Computer viruses can be transmitted via email. The recipient
> should check this email and any attachments for the presence 
> of viruses.
> The company accepts no liability for any damage caused by any virus
> transmitted by this email.
> 
> www.wipro.com
> 	
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
> 
