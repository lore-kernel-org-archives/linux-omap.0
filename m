From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 2/2] gpio: omap: convert to use generic irq handler
Date: Thu, 15 Oct 2015 19:33:43 +0300
Message-ID: <561FD567.3030803@ti.com>
References: <1443209283-20781-1-git-send-email-grygorii.strashko@ti.com>
 <1443209283-20781-3-git-send-email-grygorii.strashko@ti.com>
 <CACRpkdYDrcwa+h2Lxd65RBMc-1n9CCyVDz1qjc2U1MEU2GP7hA@mail.gmail.com>
 <560F07CC.9050205@ti.com> <alpine.DEB.2.11.1510120947220.6097@nanos>
 <561D4CAB.1060704@ti.com> <alpine.DEB.2.11.1510132031360.25029@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1510132031360.25029@nanos>
Sender: linux-gpio-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dan Murphy <dmurphy@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Austin Schuh <austin@peloton-tech.com>, philipp@peloton-tech.com, linux-rt-users@vger.kernel.org, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Thomas,

On 10/13/2015 09:33 PM, Thomas Gleixner wrote:
> Grygorii,
>
> On Tue, 13 Oct 2015, Grygorii Strashko wrote:
>> I'd very appreciate for any advice of how to better proceed with your request.
>>   - I can try to apply and re-send only patches marked by '*'
>>   - I can prepare branch with all above patches
>
> Please provide a branch on top of 4.1.10 which contains the whole
> lot. I have a look at it and decide then how to go from there.

I've prepared branch linux-4.1.10-ti-gpio:
in git@git.ti.com:~gragst/ti-linux-kernel/gragsts-ti-linux-kernel.git

based on top of
  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
  branch : linux-4.1.y
  commit : 27f1b7f Linux 4.1.10


Also, I've tried to merge it in linux-4.1.y-rt and found that merge can 
be done without merge conflicts if below patch is reverted:
"
    Revert "gpio: omap: use raw locks for locking"
    This reverts commit 26dc4f70eb09ff7d36b1e6cd720e65b3c69098ae
"

-- 
regards,
-grygorii
