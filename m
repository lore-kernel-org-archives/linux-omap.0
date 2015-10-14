From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 20/25] dmaengine: edma: Simplify the interrupt handling
Date: Wed, 14 Oct 2015 14:16:06 +0300
Message-ID: <561E3976.3050100@ti.com>
References: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
 <1443088932-21731-21-git-send-email-peter.ujfalusi@ti.com>
 <20151014102039.GK27370@localhost> <561E3883.6000705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <561E3883.6000705@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: nsekhar@ti.com, linux@arm.linux.org.uk, olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/14/2015 02:12 PM, Peter Ujfalusi wrote:
>>> +		} else if (edma_read(ecc, EDMA_QEMR)) {
>>> +			dev_dbg(ecc->dev, "QEMR %02x\n",
>>> +				edma_read(ecc, EDMA_QEMR));
>>> +			for (i =3D 0; i < 8; i++) {
>>> +				if (edma_read(ecc, EDMA_QEMR) & BIT(i)) {
>>> +					/* Clear the corresponding IPR bits */
>>> +					edma_write(ecc, EDMA_QEMCR, BIT(i));
>>> +					edma_shadow0_write(ecc, SH_QSECR,
>>> +							   BIT(i));
>>> +
>>> +					/* NOTE:  not reported!! */
>>
>> what does this mean?
>=20
> For QEMR and CCERR registers the Linux driver only acks the event, bu=
t do not
> do anything.
> In Linux we are not using the qDMA of the eDMA3 and there is not much=
 we can
> do when the CCERR happens.
> Hrm, probably moving the CCERR print to dev_err() might be useful, bu=
t again I
> have not seen this happen. But if it does, we need to come up with so=
mething
> to avoid it. Basically repartition the use of Transfer Controllers, b=
ut this
> can not be done with this stack. An upcoming series will give us ways=
 to fine
> tune the use of TCs.

In the interrupt handler simplification patch I move the CCERR to dev_w=
arn()
so I leave it like this for this patch - as the function has been just =
moved
down in the code to be able to call the actual handler of the events.

--=20
P=E9ter
