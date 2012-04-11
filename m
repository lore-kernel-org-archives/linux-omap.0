From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Get rid of of_have_populated_dt() usage
Date: Wed, 11 Apr 2012 15:59:55 +0530
Message-ID: <4F855D23.2090803@ti.com>
References: <1334138593-9692-1-git-send-email-rnayak@ti.com> <20120411100956.GT12064@arwen.pp.htv.fi> <4F855BDC.9070103@ti.com> <20120411102632.GY12064@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <20120411102632.GY12064@arwen.pp.htv.fi>
Sender: linux-mmc-owner@vger.kernel.org
To: balbi@ti.com
Cc: cjb@laptop.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, b-cousson@ti.com, Balaji TK <balajitk@ti.com>, Rob Herring <rob.herring@calxeda.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-omap@vger.kernel.org

On Wednesday 11 April 2012 03:56 PM, Felipe Balbi wrote:
> On Wed, Apr 11, 2012 at 03:54:28PM +0530, Rajendra Nayak wrote:
>> On Wednesday 11 April 2012 03:39 PM, Felipe Balbi wrote:
>>> On Wed, Apr 11, 2012 at 03:33:13PM +0530, Rajendra Nayak wrote:
>>>> @@ -1564,7 +1564,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>>   			 * can't be allowed when booting with device
>>>>   			 * tree.
>>>>   			 */
>>>> -			(!of_have_populated_dt())) {
>>>> +			!host->dev->of_node) {
>>>
>>> won't compile
>>>
>> why? compiles fine for me.
>
> aren't you missing the opening parenthesis ? Or is there a something not
> shown in the context ?
>
Its the missing context thats confusing :-)

This is how the code looks in the file after the patch.

                if ((OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET) &&
                         (ios->vdd == DUAL_VOLT_OCR_BIT) &&
                         /*
                          * With pbias cell programming missing, this
                          * can't be allowed when booting with device
                          * tree.
                          */
                         !host->dev->of_node) {



