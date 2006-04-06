From: ruchir.gulati@tcs.com
Subject: Re: Linux audio driver OMAP5912
Date: Thu, 6 Apr 2006 15:36:34 +0530
Message-ID: <OF24DCAEEA.2584161E-ON65257148.00371CD2-65257148.00377BD1@tcs.com>
References: <000801c658cf$54aac4b0$0301a8c0@hydra>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <000801c658cf$54aac4b0$0301a8c0@hydra>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Thank you Michal, Sriram, and Nishant,

I tried the steps mentioned at the website suggested by you and they work. 
I am able to play sound. Actually i have a raw PCM file which contains 
mono speech sampled at 8KHz and uses 16 bits/sample resolution. 
Though this file is playing, it seems to be getting played very fast in 
spite of doing the proper configuration. Is it necessary to convert any 
PCM file to the *.au file before attempting to play it or can I also play 
a simple PCM file as described above? If yes, then how should I go about 
it?

Thanks in advance....
Ruchir Gulati
Tata Consultancy Services Limited
M2 & N2, Sector V, Block GP,
Salt Lake Electronics Complex
Kolkata - 700091,West Bengal
India
Mailto: ruchir.gulati@tcs.com
Website: http://www.tcs.com



"Michal Szabat" <michal611@interia.pl> 
04/05/2006 10:08 PM

To
<linux-omap-open-source@linux.omap.com>, <ruchir.gulati@tcs.com>
cc

Subject
Re: Linux audio driver OMAP5912







----- Original Message ----- 
From: <ruchir.gulati@tcs.com>
To: <linux-omap-open-source@linux.omap.com>
Sent: Wednesday, April 05, 2006 1:42 PM
Subject: Linux audio driver OMAP5912


>
> Hello,
>
> I am trying to record/capture and play/render audio on the OMAP5912 OSK
> supplied by Spectrum Digital. I am aware of the TLV320AIC23 Audio Codec 
IC
> present on this board. I want to record and play the audio using the GPP
> or the ARM9 processor, through the MotaVista Linux OS present on the ARM
> processor.
>
> Can anyone please tell me how can I do this? If there is any driver (I
> mean Linux driver for OMAP5912) available for this, then where is it? As
> of now I have searched the OMAP page on the Spectrum Digital webpage and 
a
> few other websites, but without any success.
>
> If anyone has worked on such a thing, please help with this! Or, if this
> is not possible, please let me know, so that I could take some other
> approach....
>
> Thanks in advance,
> Ruchir Gulati
> Embedded Systems Group,
> TATA Consultancy Services Ltd.
>
> Notice: The information contained in this e-mail message and/or 
> attachments to it may contain confidential or privileged information. If 

> you are not the intended recipient, any dissemination, use, review, 
> distribution, printing or copying of the information contained in this 
> e-mail message and/or attachments to it are strictly prohibited.   If 
you 
> have received this communication in error, please notify us by reply 
> e-mail or telephone and immediately and permanently delete the message 
and 
> any attachments.  Thank you
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>

Hello.

I want to compress audio to mp3 or other format, by now without cuccess.
You can check it http://oskfordummies.hp.infoseek.co.jp/howto/audio.html. 


----------------------------------------------------------------------
Poznaj Stefana! Zmien komunikator! >>> http://link.interia.pl/f1924


ForwardSourceID:NT0000413E 


Notice: The information contained in this e-mail message and/or attachments to it may contain confidential or privileged information.   If you are not the intended recipient, any dissemination, use, review, distribution, printing or copying of the information contained in this e-mail message and/or attachments to it are strictly prohibited.   If you have received this communication in error, please notify us by reply e-mail or telephone and immediately and permanently delete the message and any attachments.  Thank you
