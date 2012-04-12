From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v4 0/7] Add TI EMIF SDRAM controller driver
Date: Thu, 12 Apr 2012 13:15:16 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204121304050.29473@utopia.booyaka.com>
References: <1331934707-29487-1-git-send-email-aneesh@ti.com> <alpine.DEB.2.00.1204112042070.29473@utopia.booyaka.com> <20120412030044.GA26236@kroah.com> <4F867A95.9030104@ti.com> <20120412131045.GB31384@kroah.com> <C8443D0743D26F4388EA172BF4E2A7A93E95947E@DQHE04.ent.ti.com>
 <alpine.DEB.2.00.1204121053570.29473@utopia.booyaka.com> <4F87240F.6060902@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-619568094-1334258116=:29473"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4F87240F.6060902@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "Mohammed, Afzal" <afzal@ti.com>, Greg KH <greg@kroah.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "V, Aneesh" <aneesh@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "mgreer@animalcreek.com" <mgreer@animalcreek.com>, "msalter@redhat.com" <msalter@redhat.com>
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-619568094-1334258116=:29473
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Beno=EEt,

On Thu, 12 Apr 2012, Cousson, Benoit wrote:

> The LPDDR2 spec does consider as well NVM (Non Volatile Memory), so I thi=
nk we
> should stick to driver/memory for EMIF.

Hmm good point!

> > So perhaps something like drivers/memory/dram/ for the SDRAM controller=
s,
> > and maybe drivers/memory/ for the GPMC?
>=20
> In fact Felipe was considering something else for that kind of general pu=
rpose
> bus driver like GMPC, C2C and LLI...
>=20
> ... But I do not remember the name :-)

It would be nice if we could separate IP blocks that can drive an Ethernet=
=20
controller or modem chip from the DRAM controllers; they are quite=20
different beasts from a common API standpoint.


- Paul
--155748971-619568094-1334258116=:29473--
