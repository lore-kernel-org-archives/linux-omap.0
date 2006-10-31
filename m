From: Philip Balister <philip@balister.org>
Subject: Re: kernel 2.6.18 dsp gateway problems and tlv320aic23 problem
 osk591 2
Date: Tue, 31 Oct 2006 10:23:52 -0500
Message-ID: <45476A88.7010504@balister.org>
References: <22CECCE071A8DC4CAB2412DC44CBEDF107A5A7AD@apgrb1atc-0058e.atc.army.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <22CECCE071A8DC4CAB2412DC44CBEDF107A5A7AD@apgrb1atc-0058e.atc.army.mil>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Carlos, John J DA CIV USA ATC" <john.carlos@atc.army.mil>
Cc: Linux-Omap-Open-Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


I can run aplay /dev/urandom on my OSK. This emits an appropriate hiss 
and I can adjust the volume with alsamixer.

I built my kernel using this recipe from OE:

http://www.openembedded.org/repo/org.openembedded.dev/packages/linux/linux-omap1_2.6.18-omap1.bb

defconfig is here. I use the eabi version.

http://www.openembedded.org/filebrowser/org.openembedded.dev/packages/linux/linux-omap1-2.6.18-omap1

Philip


Carlos, John J DA CIV USA ATC wrote:
> Hello all,
> 
>   I have two issues.  I'm trying to get audio codec to work.  On kernel
> 2.6.17.13 with dsp patch the dsp gateway stuff works but I can't get audio
> support to compile without errors and it locks the kernel when trying to
> load.
> 
>   I tried kernel 2.6.18 with omap-1 patch.  The dsp module will not load to
> many undefined externals (is there a patch for this)  Also the audio codec
> modules all compile with no errors but when I modprobe tlv320aic23.ko for
> the i2c support for the codec the kernel still locks up.  Has anyone been
> able to get audio support working on osk5912 in either of the two kernel
> versions I mentioned.
> 
> Thanks,
> John
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
