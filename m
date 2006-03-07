From: "Michal Szabat" <michal611@interia.pl>
Subject: Re: Which patches for 2.6.15 for 5912OSK?
Date: Tue, 7 Mar 2006 19:32:44 +0100
Message-ID: <001d01c64215$92fbf4d0$0301a8c0@hydra>
References: <00da01c641f7$f4091000$642aa8c0@BUFFY>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Richard Copeman <richard.copeman@lauterbach.co.uk>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


----- Original Message ----- 
From: "Richard Copeman" <richard.copeman@lauterbach.co.uk>
To: <linux-omap-open-source@linux.omap.com>
Sent: Tuesday, March 07, 2006 4:01 PM
Subject: Which patches for 2.6.15 for 5912OSK?


> Hi,
>
>
>
> I have the 2.6.15 source tree from kernel.org and wonder if anyone can 
> tell
> me which patches I need to apply so I can successfully build for my 
> 5912OSk
> board?
>
> I have a working 2.6.13 image but I can't seem to get the DSP gateway to
> work properly and hoped that 2.6.15 would improve matters.
>
>
>
> Thanks,
>
>
>
> Richard.
>

Hello.

I compiled kernel 2.6.11 with patch-2.6.11-omap1, 
patch-2.6.11-omap1-dspgw3.2 and 2.6.12 with patch-2.6.12-omap1, 
patch-2.6.12-omap1-dspgw3.3 and I can't run esamples from dspgateway. You 
shuld use patch-2.6.15-omap1. I can't find patch-2.6.15-omap1-dspgw, maybe 
patch-2.6.12-omap1-dspgw3.3 can work. Please send me message if kernel 
2.6.15 work properly with dspgateway. 
