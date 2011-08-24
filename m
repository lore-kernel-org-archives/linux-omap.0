From: Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
Subject: Re: USB DMA on Beagleboard xM (DM37x)
Date: Wed, 24 Aug 2011 07:35:43 -0700 (PDT)
Message-ID: <30852752.1245.1314196543737.JavaMail.geo-discussion-forums@yqlo5>
References: <4f8e974b-a67d-4020-b39d-a3d7ca90fe42@w22g2000prj.googlegroups.com>
Reply-To: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1244_10587044.1314196543735"
Return-path: <beagleboard+bncCKmZx5vdGRDCmNTyBBoESM7PKw-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <4f8e974b-a67d-4020-b39d-a3d7ca90fe42-3/KZq9SnIEE2swWmpKVAvmB/v6IoIuQBVpNB7YpNyf8@public.gmane.org>
List-Post: <http://groups.google.com/group/beagleboard/post?hl=en_US>, <mailto:beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:beagleboard+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/beagleboard?hl=en_US>
Sender: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Unsubscribe: <http://groups.google.com/group/beagleboard/subscribe?hl=en_US>,
 <mailto:beagleboard+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

------=_Part_1244_10587044.1314196543735
Content-Type: text/plain; charset=ISO-8859-1

>On Tuesday, August 23, 2011 1:33:43 PM UTC-4, Esaias wrote:
>Hello, 
>
>I have written a USB driver for the OTG controller (just to be used as 
>peripheral) for a USB Stack (Not using Linux). 
>The driver is able to Tx/Rx at High Speed but I am only getting a 
>throughput of 3MB/s. I think I need DMA to get a higher throughput, 
>however I can't find the documentation for the DMA in the USB 
>controller. I need to know where the registers are located. 
>
>So my questions: 
>1. Does BB xM uses CPPI 4.1 DMA? 

Depends on which kernel you are talking about, but my understanding is that 
it is *NOT* enabled in the mainline. There have been a few candidate patches 
floated, but nothing accepted yet. You can google for it. There was an issue 
that prevents you from using the DMA in both directions and thus there was a 
desire to use the sDMA (system DMA) for transfers in one of the directions.

My impression might be quite wrong based on [1].

>2. Where can I find the registers offsets for the DMA in the USB 
>controller? 
>

Here's the TI answer I got (yes, I work for TI, but I go through the typical 
support channels to get answers for the BeagleBoard community):

      You can refer to linux code for Mentor DMA implementation. For 
document you should Contact local TI team and get it after signing NDA 
needed for this document.


I see you got a bit of an answer from the TI e2e forums [1].  It would be 
great if you could reply back here as well with whatever you learn.

The individual registers seem to be defined in [4] or [5]. I wanted to find 
where the base was introduced to see if the whole driver was introduced 
together, but it doesn't look like it to me [3].

When lost in the code, it is time to revert to the TRM [7].  In the L4-Core 
Memory Space Mapping table, you can find the USB OTG controller base at 
0x480AB000, but that doesn't match the 0x4805e300 found in [3], which is 
just shown as RESERVED in the memory mapping table. :( 

[1] 
http://e2e.ti.com/support/dsp/davinci_digital_media_processors/f/537/p/129614/464698.aspx
[2] 
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=drivers/usb/musb/cppi_dma.c;h=149f3f310a0a1f9903793ca5f56daaf1038a4024;hb=HEAD
[3] 
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=f4e4c324a5f81f18156499d1ade3732ba1f5b523
[4] 
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=drivers/usb/musb/musb_regs.h;h=82410703dcd3c1d87e688007c52cd737675d03d6;hb=HEAD
[5] 
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=drivers/usb/musb/cppi_dma.h;h=59bf949e589b85a086be064ffb037a77bedc7e24;hb=HEAD
[6] 
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=drivers/usb/musb/musbhsdma.h;h=320fd4afb93f7cd31b05e26e125819ae03af95c2;hb=HEAD
[7] http://focus.ti.com/docs/prod/folders/print/dm3730.html (search for 
"technical reference manual")

>Any other information that might be helpful when adding this 
>functionality to my USB driver? 
>

If it is a Linux driver, include linux-omap (added to the CC) to the 
discussion. There are some USB experts there who might chime in if you are 
working on advancing the state of the mainline driver to include DMA 
support.  If you have sufficient time to devote to improving the performance 
of the driver for the community, I can be a contact to enable the NDA.


>Thanks, 
>
>- Esaias

-- 
You received this message because you are subscribed to the Google Groups "Beagle Board" group.
To view this discussion on the web visit https://groups.google.com/d/msg/beagleboard/-/JwWCwpQemOQJ.
To post to this group, send email to beagleboard-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to beagleboard+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit this group at http://groups.google.com/group/beagleboard?hl=en.


------=_Part_1244_10587044.1314196543735
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

&gt;On Tuesday, August 23, 2011 1:33:43 PM UTC-4, Esaias wrote:<br>&gt;Hell=
o, <br> &gt;<br>&gt;I have written a USB driver for the OTG controller (jus=
t to be used as <br>&gt;peripheral) for a USB Stack (Not using Linux). <br>=
&gt;The driver is able to Tx/Rx at High Speed but I am only getting a <br>&=
gt;throughput of 3MB/s. I think I need DMA to get a higher throughput, <br>=
&gt;however I can't find the documentation for the DMA in the USB <br>&gt;c=
ontroller. I need to know where the registers are located. <br> &gt;<br>&gt=
;So my questions: <br>&gt;1. Does BB xM uses CPPI 4.1 DMA? <br><br>Depends =
on which kernel you are talking about, but my understanding is that it is *=
NOT* enabled in the mainline.  There have been a few candidate patches floa=
ted, but nothing accepted yet.  You can google for it.  There was an issue =
that prevents you from using the DMA in both directions and thus there was =
a desire to use the sDMA (system DMA) for transfers in one of the direction=
s.<br><br>My impression might be quite wrong based on [1].<br> <br>&gt;2. W=
here can I find the registers offsets for the DMA in the USB <br>&gt;contro=
ller? <br>&gt;<br><br>Here's the TI answer I got (yes, I work for TI, but I=
 go through the typical support channels to get answers for the BeagleBoard=
 community):<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; You can refer to linux c=
ode for Mentor DMA implementation. For document you should Contact local TI=
 team and get it after signing NDA needed for this document.<br> <br><br>I =
see you got a bit of an answer from the TI e2e forums [1].&nbsp; It would b=
e great if you could reply back here as well with whatever you learn.<br><b=
r>The individual registers seem to be defined in [4] or [5].  I wanted to f=
ind where the base was introduced to see if the whole driver was introduced=
 together, but it doesn't look like it to me [3].<br><br>When lost in the c=
ode, it is time to revert to the TRM [7].&nbsp; In the L4-Core Memory Space=
 Mapping table, you can find the USB OTG controller base at 0x480AB000, but=
 that doesn't match the 0x4805e300 found in [3], which is just shown as RES=
ERVED in the memory mapping table. :( <br><br>[1] http://e2e.ti.com/support=
/dsp/davinci_digital_media_processors/f/537/p/129614/464698.aspx<br>[2] htt=
p://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dblob;f=3Ddr=
ivers/usb/musb/cppi_dma.c;h=3D149f3f310a0a1f9903793ca5f56daaf1038a4024;hb=
=3DHEAD<br>[3] http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.g=
it;a=3Dcommitdiff;h=3Df4e4c324a5f81f18156499d1ade3732ba1f5b523<br>[4] http:=
//git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dblob;f=3Ddriv=
ers/usb/musb/musb_regs.h;h=3D82410703dcd3c1d87e688007c52cd737675d03d6;hb=3D=
HEAD<br>[5] http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;=
a=3Dblob;f=3Ddrivers/usb/musb/cppi_dma.h;h=3D59bf949e589b85a086be064ffb037a=
77bedc7e24;hb=3DHEAD<br>[6] http://git.kernel.org/?p=3Dlinux/kernel/git/tor=
valds/linux.git;a=3Dblob;f=3Ddrivers/usb/musb/musbhsdma.h;h=3D320fd4afb93f7=
cd31b05e26e125819ae03af95c2;hb=3DHEAD<br>[7] http://focus.ti.com/docs/prod/=
folders/print/dm3730.html (search for "technical reference manual")<br> <br=
>&gt;Any other information that might be helpful when adding this <br>&gt;f=
unctionality to my USB driver? <br>&gt;<br><br>If it is a Linux driver, inc=
lude linux-omap (added to the CC) to the discussion.  There are some USB ex=
perts there who might chime in if you are working on advancing the state of=
 the mainline driver to include DMA support.&nbsp; If you have sufficient t=
ime to devote to improving the performance of the driver for the community,=
 I can be a contact to enable the NDA.<br> <br> <br>&gt;Thanks, <br> &gt;<b=
r>&gt;- Esaias<br><br>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups "=
Beagle Board" group.<br />
To view this discussion on the web visit <a href=3D"https://groups.google.c=
om/d/msg/beagleboard/-/JwWCwpQemOQJ">https://groups.google.com/d/msg/beagle=
board/-/JwWCwpQemOQJ</a>.<br />=20
To post to this group, send email to beagleboard-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org<br />
To unsubscribe from this group, send email to beagleboard+unsubscribe@googl=
egroups.com.<br />

For more options, visit this group at http://groups.google.com/group/beagle=
board?hl=3Den.<br />



------=_Part_1244_10587044.1314196543735--
