From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 5/9] usb: dwc3: core: make dual-role work with OTG irq
Date: Fri, 4 Sep 2015 12:13:28 +0300
Message-ID: <55E960B8.2080409@ti.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
 <1441203864-15786-6-git-send-email-rogerq@ti.com>
 <20150902144338.GG8299@saruman.tx.rr.com> <55E85082.5040006@ti.com>
 <20150903155125.GC4031@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150903155125.GC4031@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 03/09/15 18:51, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Sep 03, 2015 at 04:52:02PM +0300, Roger Quadros wrote:
>>>>  	if (on) {
>>>> -		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
>>>> +		/* OCTL.PeriMode = 0 */
>>>> +		reg = dwc3_readl(dwc->regs, DWC3_OCTL);
>>>> +		reg &= ~DWC3_OCTL_PERIMODE;
>>>> +		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
>>>> +		/* unconditionally turn on VBUS */
>>>> +		reg |= DWC3_OCTL_PRTPWRCTL;
>>>> +		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
>>>>  		/* start the HCD */
>>>>  		usb_otg_start_host(fsm, true);
>>>>  	} else {
>>>>  		/* stop the HCD */
>>>>  		usb_otg_start_host(fsm, false);
>>>> +		/* turn off VBUS */
>>>> +		reg = dwc3_readl(dwc->regs, DWC3_OCTL);
>>>> +		reg &= ~DWC3_OCTL_PRTPWRCTL;
>>>> +		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
>>>> +		/* OCTL.PeriMode = 1 */
>>>> +		reg = dwc3_readl(dwc->regs, DWC3_OCTL);
>>>> +		reg |= DWC3_OCTL_PERIMODE;
>>>> +		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
>>>>  	}
>>>
>>> it looks like you're not really following the fluxchart from SNPS
>>> documentation, see Figure 11-4 on section 11.1.4.5
>>
>> Did you mean that I'm ignoring all OTG bits (HNP/SRP/ADP)?
> 
> yes and no :-)  There's a rather complex flux chart which details how we
> switch from host to peripheral and vice versa. We need to follow that to
> the smallest details since that's what IP provider considers to be
> correct. If we deviate from that we should have very strong reasons for
> doing so and we also want big, fat, long comments in source code
> detailing why and how we're deviating :-)
> 
Understood. I'll update this accordingly.

- --
cheers,
- -roger
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV6WC4AAoJENJaa9O+djCTWSEP/jq0jX2KJVjqKeSk60wyDIEH
AIGXpaupz4XCFRsLFHlEomAoWHEzmbdwQlcI5gyB4N6IgF6xfxX71AZnytw4k4ja
sFxQq/qNSPWa4yiEY9MFbIPuiRMFcLOB5VbemGpcZq4n31yaKlbLtHMDEC8zPmdY
yfnUz7raY2tID/+wOASAM+nDXVS6nFztWXCrz+4TxwDaH0dgwl9OAoD7nvTil3MT
UTuR34GbWcb9rCxJVYgneht1sLbkKGCkwjLRcqzhOajg87GuW38irqD9OOF+pLCm
srhYsntQyBJlvArDQKMZIyGEYHvjICWzJUo/IPA8DFS/qOrRLyrLvVHskb6pr9/y
KZL/1N+5Nbh0N0XGWKwxzVh69DqmQPuY32SN2r1xqCDzzZAnvrl9cz6ixsRq1JGK
9EvYNJlRWsdypfA8tdhPtCgXua+wYSLNewgHQSko10qeAgiaIU5/bQ/9Eb2Ys9QV
6wkhr0Gulf/hnMKXHupErhUsvSBJk2MGaaDIfUSt3mWMTRsthp2NedRE9li9bWW9
gSXcTxs8785Y7FgxFDvvqQ05rbGWNqfxkeq54ziMtH3mZ93inE7me1HbqL1jgEuh
NFrNsAKYc000syvnqunzl8uZMRMsICaY1aKC0riQTdpgagHgGMfadKtWXb8OdcVa
gICj2/o8MpPpv3FEniDz
=L39b
-----END PGP SIGNATURE-----
