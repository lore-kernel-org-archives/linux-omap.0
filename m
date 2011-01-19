From: Abdoulaye Walsimou GAYE <awg@embtoolkit.org>
Subject: Re: [HELP-OMAP-SERAIL] beagleboard-xM can't boot up after update
 to kernel-2.6.37
Date: Wed, 19 Jan 2011 12:07:35 +0100
Message-ID: <4D36C5F7.4030605@embtoolkit.org>
References: <AANLkTikFb7WTfCOD_GUnA=RZ22Q5_5QSDRTbcoLMtdYM@mail.gmail.com> <20110119110607.GA30211@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from walscop001.walsimou.com ([82.228.201.70]:42688 "EHLO
	bekkor.walsimou.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650Ab1ASLKo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 06:10:44 -0500
In-Reply-To: <20110119110607.GA30211@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Bob Liu <lliubbo@gmail.com>, linux-omap@vger.kernel.org

On 01/19/2011 12:06 PM, Felipe Balbi wrote:
> Hi,
>
> On Wed, Jan 19, 2011 at 06:57:33PM +0800, Bob Liu wrote:
>   
>> Any ideas?
>>     
> s/console=ttyS2,115200n8/console=ttyO2,115200n8/
>
> on your CMDLINE.
>
>   

Hi,
BTW what is major and minor number of ttyO devices?
This is not documented in devices.txt

Thanks,
AWG
