From: frq09524 <ludovic.barre@stericsson.com>
Subject: Re: [PATCH 1/7] remoteproc: resource table overhaul
Date: Tue, 22 May 2012 14:51:23 +0200
Message-ID: <4FBB8BCB.3010802@stericsson.com>
References: <1330589497-4139-1-git-send-email-ohad@wizery.com> <1330589497-4139-2-git-send-email-ohad@wizery.com> <4F6354E4.8030704@monstr.eu> <CAK=Wgbbbi4GnuHedSh6cR1LhkZr8c9q6i=_TLSL252LpPB8Xsw@mail.gmail.com> <CAK=WgbYeQr5ZwTSBo+ZJUzN7fQ--0QbC8HSjrGT-Geycs4SKcg@mail.gmail.com> <CAHTX3d+=QTZo994jct6+pPqsCniG0B2a_9q6fLdGjvcbZ7qj_A@mail.gmail.com> <CAK=WgbahzGHmvszw6HBgihN4NcPA8ceaQCNSOk_FC61bToxBXQ@mail.gmail.com> <CAHTX3dK8rDomYqWvBX1ay200AmM1dBCYD3nJ2UYbzC_SSFankw@mail.gmail.com> <4FBB5908.4010505@stericsson.com> <CAK=WgbYKMh8oifeC-A9LYq8GV_Nb7L8wc198YZujGEsp9mmvsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK=WgbYKMh8oifeC-A9LYq8GV_Nb7L8wc198YZujGEsp9mmvsw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Michal Simek <monstr@monstr.eu>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Brian Swetland <swetland@google.com>, Iliyan Malchev <malchev@google.com>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>, Rusty Russell <rusty@rustcorp.com.au>, Mark Grosen <mgrosen@ti.com>, John Williams <john.williams@petalogix.com>, Loic PALLARDY <loic.pallardy@stericsson.com>, Omar Ramirez Luna <omar.luna@linaro.org>, Guzman Lugo Fernando <fernando.lugo@ti.com>, Anna Suman <s-anna@ti.com>, Clark Rob <rob@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Saravana Kannan <skannan@codeaurora.org>, David Brown <davidb@codeaurora.org>, Kieran Bingham <kieranbingham@gmail.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

hi Ohad

In my previous patch, to find the correct subdevice that match with=20
physical memory, I used pa member of rproc_mem_entry.
but today in these 2 resources: fw_rsc_trace, fw_rsc_vdev_vring, pa=20
menber has been removed.

for fw_rsc_trace it's not a problem, because use rproc_da_to_va and=20
carveout feature.

but for fw_rsc_vdev_vring, I think use da member, like this.

dev =3D rproc_dma_find_dev(rproc, (phys_addr_t) vring->da);
va =3D dma_alloc_coherent(dev, size, &dma, GFP_KERNEL);
if (!va) {
	dev_err(dev, "dma_alloc_coherent failed\n");
	return -EINVAL;
}

are you OK ?

/BR
Ludovic Barr=E9

On 05/22/2012 11:22 AM, Ohad Ben-Cohen wrote:
> Hi Ludovic,
>
> On Tue, May 22, 2012 at 12:14 PM, frq09524<ludovic.barre@stericsson.c=
om>  wrote:
>> Ohad, for alignment I can take the latest branch of kernel.org (remo=
teproc)
>> branch for-next?
>
> Sure, it's pretty much updated sans a few simple changes.
>
> Thanks,
> Ohad.
