From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v4 0/7] Add TI EMIF SDRAM controller driver
Date: Thu, 12 Apr 2012 21:24:29 +0200
Message-ID: <4F872BED.7000703@ti.com>
References: <1331934707-29487-1-git-send-email-aneesh@ti.com> <alpine.DEB.2.00.1204112042070.29473@utopia.booyaka.com> <20120412030044.GA26236@kroah.com> <4F867A95.9030104@ti.com> <20120412131045.GB31384@kroah.com> <C8443D0743D26F4388EA172BF4E2A7A93E95947E@DQHE04.ent.ti.com> <alpine.DEB.2.00.1204121053570.29473@utopia.booyaka.com> <4F87240F.6060902@ti.com> <alpine.DEB.2.00.1204121304050.29473@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1204121304050.29473@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "Mohammed, Afzal" <afzal@ti.com>, Greg KH <greg@kroah.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "V, Aneesh" <aneesh@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "mgreer@animalcreek.com" <mgreer@animalcreek.com>, "msalter@redhat.com" <msalter@redhat.com>
List-Id: linux-omap@vger.kernel.org

On 4/12/2012 9:15 PM, Paul Walmsley wrote:
> Hi Beno=EEt,
>
> On Thu, 12 Apr 2012, Cousson, Benoit wrote:
>
>> The LPDDR2 spec does consider as well NVM (Non Volatile Memory), so =
I think we
>> should stick to driver/memory for EMIF.
>
> Hmm good point!
>
>>> So perhaps something like drivers/memory/dram/ for the SDRAM contro=
llers,
>>> and maybe drivers/memory/ for the GPMC?
>>
>> In fact Felipe was considering something else for that kind of gener=
al purpose
>> bus driver like GMPC, C2C and LLI...
>>
>> ... But I do not remember the name :-)
>
> It would be nice if we could separate IP blocks that can drive an Eth=
ernet
> controller or modem chip from the DRAM controllers; they are quite
> different beasts from a common API standpoint.

Yep, fully agree. In fact Felipe's suggestion was something like=20
drivers/ocd for off-chip devices, but maybe something like drivers/gpbu=
s=20
will highlight a little bit more the bus controller aspect of such driv=
er.

Regards,
Benoit
