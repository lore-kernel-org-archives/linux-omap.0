From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCH 2/4] Input: keypad: Add smsc ece1099 keypad driver
Date: Tue, 21 Aug 2012 17:01:47 +0530
Message-ID: <CAKdam57p_K-ui1x+u-n07PQ8aweZocDsXoFTtdk_6CAVsC+xOg@mail.gmail.com>
References: <1345545940-2232-1-git-send-email-sourav.poddar@ti.com>
	<1345545940-2232-3-git-send-email-sourav.poddar@ti.com>
	<20120821104647.GU10347@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20120821104647.GU10347@arwen.pp.htv.fi>
Sender: linux-input-owner@vger.kernel.org
To: balbi@ti.com
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Aug 21, 2012 at 4:16 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Tue, Aug 21, 2012 at 04:15:38PM +0530, Sourav Poddar wrote:
>> +static struct platform_driver smsc_driver = {
>> +     .driver = {
>> +             .name   = "smsc-keypad",
>> +             .of_match_table = of_match_ptr(smsc_keypad_dt_match),
>> +             .owner  = THIS_MODULE,
>> +     },
>> +     .probe          = smsc_probe,
>> +     .remove         = smsc_remove,
>
> one extra comment which I forgot. You probably should put your remove on
> __devexit and add __devexit_p(smsc_remove) here.
>
yes, Will do it.
> --
> balbi
