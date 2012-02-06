From: Thomas Klute <thomas2.klute@uni-dortmund.de>
Subject: Re: Gumstix Overo: linux-omap newer than 2.6.36 does not boot
Date: Mon, 06 Feb 2012 17:20:07 +0100
Message-ID: <4F2FFDB7.3020107@uni-dortmund.de>
References: <4F2FF18F.2070801@uni-dortmund.de> <CANOLnONFXoGzs7ZpVf4J3-E-fdhFf8ygMWu68_qMN_OWRVGj=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.HRZ.Uni-Dortmund.DE ([129.217.128.51]:37793 "EHLO
	unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542Ab2BFQUK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Feb 2012 11:20:10 -0500
In-Reply-To: <CANOLnONFXoGzs7ZpVf4J3-E-fdhFf8ygMWu68_qMN_OWRVGj=w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org

Am 06.02.2012 17:08, schrieb Grazvydas Ignotas:
> On Mon, Feb 6, 2012 at 5:28 PM, Thomas Klute
> <thomas2.klute@uni-dortmund.de> wrote:
>> Hi,
>>
>> I'm working with various Gumstix Overo boards (OMAP 35XX) and found that
>> kernel versions from the linux-omap tree newer than 2.6.36 fail to boot
>> on the Overo, as in no output after "Uncompressing Linux... done,
>> booting the kernel." See attached for the complete serial console output
>> (latest 3.3 git version as of this writing, using omap2plus_defconfig).
> 
> OMAP serial driver changed around that time.
> Do you pass correct console through bootags, like
> console=ttyO2,115200n8 (instead of ttyS*)?

Thanks a lot, changing the console parameter solved the problem. :-)
