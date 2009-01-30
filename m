From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: [PATCH] OMAP3 McSPI:  Adds context save/restore
Date: Fri, 30 Jan 2009 11:53:16 +0530
Message-ID: <015001c982a3$3e25e200$LocalHost@wipultra793>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02F535F346@dbde02.ent.ti.com> <20090129190605.GA7792@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47560 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296AbZA3GXe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Jan 2009 01:23:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Imre Deak <imre.deak@nokia.com>, "ext Nayak, Rajendra" <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>


----- Original Message ----- 
From: "Imre Deak" <imre.deak@nokia.com>
To: "ext Nayak, Rajendra" <rnayak@ti.com>
Cc: <linux-omap@vger.kernel.org>; "Kevin Hilman" 
<khilman@deeprootsystems.com>; "V, Hemanth" <hemanthv@ti.com>
Sent: Friday, January 30, 2009 12:36 AM
Subject: Re: [PATCH] OMAP3 McSPI: Adds context save/restore


> On Wed, Jan 28, 2009 at 10:11:29AM +0100, ext Nayak, Rajendra wrote:
>> From: Hemanth V <hemanthv@ti.com>
>>
>> This patch adds context save/restore feature to McSPI driver.
>> This has been tested by instrumenting the driver code i.e by
>> adding a McSPI softreset in omap2_mcspi_disable_clocks function.
>>
>> This patch includes review comment fixes
>>
>> Signed-off-by: Hemanth V <hemanthv@ti.com>
>>
>> ---
>>  drivers/spi/omap2_mcspi.c |   97 
>> ++++++++++++++++++++++++++++++++++++----------
>>  1 files changed, 77 insertions(+), 20 deletions(-)
>>
>> Index: linux-omap-2.6/drivers/spi/omap2_mcspi.c
>> ===================================================================
>> --- linux-omap-2.6.orig/drivers/spi/omap2_mcspi.c       2009-01-27 
>> 11:45:06.000000000 +0530
>> +++ linux-omap-2.6/drivers/spi/omap2_mcspi.c    2009-01-27 
>> 11:53:16.000000000 +0530
>>
>> [...]
>>
>> +static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
>> +{
>> +       struct spi_master *spi_cntrl;
>> +       spi_cntrl = mcspi->master;
>> +
>> +       /* McSPI: context restore */
>> +       mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_MODULCTRL,
>> +                       omap2_mcspi_ctx[spi_cntrl->bus_num - 
>> 1].modulctrl);
>> +
>> +       mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_SYSCONFIG,
>> +                       omap2_mcspi_ctx[spi_cntrl->bus_num - 
>> 1].sysconfig);
>> +
>> +       mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_CHCONF0,
>> +                       omap2_mcspi_ctx[spi_cntrl->bus_num - 1].chconf0);
>
> You have to restore this to the proper CHCONF register. And in the
> current form you have to restore all of them.

Currently only CS0 CHCONF i.e chconf0 is being saved and restored, since its 
the only one configured and used
by the driver.

>
>> +
>> +
>> +       mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE,
>> +                       omap2_mcspi_ctx[spi_cntrl->bus_num - 
>> 1].wakeupenable);
>> +}
>> +static void omap2_mcspi_disable_clocks(struct omap2_mcspi *mcspi)
>> +{
>> +       clk_disable(mcspi->ick);
>> +       clk_disable(mcspi->fck);
>> +}
>> +
>> [...]
>>
>> @@ -537,6 +593,8 @@
>>
>>         mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
>>
>> +       omap2_mcspi_ctx[spi_cntrl->bus_num - 1].chconf0 = l;
>
> And here save it to a slot based on CS.
>
> --Imre
>
>
>
> 

