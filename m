From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 11/23] ARM/dmaengine: edma: Merge the two drivers under
 drivers/dmaengine
Date: Tue, 15 Sep 2015 09:45:16 +0300
Message-ID: <55F7BE7C.1080703@ti.com>
References: <1441974442-8233-1-git-send-email-peter.ujfalusi@ti.com>
 <1441974442-8233-12-git-send-email-peter.ujfalusi@ti.com>
 <20150914161233.GL4215@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150914161233.GL4215@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk, olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/14/2015 07:12 PM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [150911 05:35]:
>> Move the code out from arch/arm/common and merge it inside of the dm=
aengine
>> driver.
>> This change is done with as minimal change to the code as possible t=
o avoid
>> any possibilities to introducing regression.
>=20
> You should check your git config so it uses -M option to git diff
> to detect renames.

I'm moving the code form arch/arm/common/edma.c inside of the already e=
xisting
drivers/dma/edma.c
The diff looks the same with -M or -C since during the code move most l=
ine
needed to be changed (struct edma -> struct edma_cc). But the merge its=
elf
does not change how the code works at this point.

> Anyways, assuming you're just moving code, for
> the omap parts:
>=20
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks,
P=E9ter
