From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] PCI: dra7xx: mark dra7xx_pcie_msi irq as
 IRQF_NO_THREAD
Date: Tue, 8 Dec 2015 10:05:56 +0100
Message-ID: <20151208090555.GA19438@linutronix.de>
References: <1448027966-21610-1-git-send-email-grygorii.strashko@ti.com>
 <20151204184619.GD20125@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151204184619.GD20125@localhost>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, tony@atomide.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-omap@vger.kernel.org

* Bjorn Helgaas | 2015-12-04 12:46:19 [-0600]:

>The backtrace might be OK (maybe slightly overkill), but all the
>stack addresses are certainly irrelevant and distracting.  We only
>need enough to recognize the problem.  I don't think the modules list
>is relevant either.

I would shorten it to the bare minimum. Also the patch description
itself could be truncated to the required bits=E2=80=A6

>> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dr=
a7xx.c
>> index 8c36880..0415192 100644
>> --- a/drivers/pci/host/pci-dra7xx.c
>> +++ b/drivers/pci/host/pci-dra7xx.c
>> @@ -301,8 +301,19 @@ static int __init dra7xx_add_pcie_port(struct d=
ra7xx_pcie *dra7xx,
>>  		return -EINVAL;
>>  	}
>> =20
>> +	/*
>> +	 * Mark dra7xx_pcie_msi IRQ as IRQF_NO_THREAD
>> +	 * On -RT and if kernel is booting with "threadirqs" cmd line para=
meter
>> +	 * the dra7xx_pcie_msi_irq_handler() will be forced threaded but,
>> +	 * in the same time, it's IRQ dispatcher and calls generic_handle_=
irq(),
>> +	 * which, in turn, will be resolved to handle_simple_irq() call.
>> +	 * The handle_simple_irq() expected to be called with IRQ disabled=
, as
>> +	 * result kernle will display warning:
>> +	 * "irq XXX handler YYY+0x0/0x14 enabled interrupts".
>> +	 */

=E2=80=A6not to mention this piece. d7ce4377494a ("powerpc/fsl_msi: mar=
k the msi
cascade handler IRQF_NO_THREAD") fixes the same bug in arch/ppc so they
bypassed you fixing it.

>>  	ret =3D devm_request_irq(&pdev->dev, pp->irq,
>> -			       dra7xx_pcie_msi_irq_handler, IRQF_SHARED,
>> +			       dra7xx_pcie_msi_irq_handler,
>> +			       IRQF_SHARED | IRQF_NO_THREAD,
>>  			       "dra7-pcie-msi",	pp);
>
>There's similar code in exynos_add_pcie_port(), imx6_add_pcie_port(),
>and spear13xx_add_pcie_port().  Do they need similar changes?  If not,
>why not?

You are right. The request for the handler exynos_pcie_msi_irq_handler(=
),
imx6_pcie_msi_handler() and spear13xx_pcie_irq_handler() needs same
treatment.
Additionally we have:

arch/mips/pci/msi-octeon.c: if (request_irq(OCTEON_IRQ_PCI_MSI0, octeon=
_msi_interrupt0,
arch/sparc/kernel/pci_msi.c:    err =3D request_irq(irq, sparc64_msiq_i=
nterrupt, 0,
drivers/pci/host/pci-tegra.c:   err =3D request_irq(msi->irq, tegra_pci=
e_msi_irq, 0,
drivers/pci/host/pcie-rcar.c:   err =3D devm_request_irq(&pdev->dev, ms=
i->irq1, rcar_pcie_msi_irq,
drivers/pci/host/pcie-rcar.c:   err =3D devm_request_irq(&pdev->dev, ms=
i->irq2, rcar_pcie_msi_irq,
drivers/pci/host/pcie-xilinx.c: err =3D devm_request_irq(dev, port->irq=
, xilinx_pcie_intr_handler,

which require the same kind of fix=E2=80=A6

>I see your discussion about DRA7 hardware design, but my impression is
>that this problem affects anybody who calls dw_handle_msi_irq() from a
>handler registered with IRQF_SHARED.

=E2=80=A6 brecause all of them invoke generic_handle_irq() from the req=
usted
handler. generic_handle_irq grabs raw_locks and this needs to run in
raw-irq context.
IRQF_SHARED could probably go away. The IRQ is mostlikely exclusive
assigned in each SoC for MSI interrupt demux.

>Bjorn

Sebastian
