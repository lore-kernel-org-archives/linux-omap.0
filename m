From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCHv3 01/11] staging: tidspbridge: replace iommu custom for
 opensource implementation
Date: Mon, 18 Oct 2010 15:24:32 +0300
Message-ID: <AANLkTi=ELmWVYmGJB2zJtpenpiZo_xajrmJBphX3hSRD@mail.gmail.com>
References: <1286310944-25035-1-git-send-email-x0095840@ti.com>
	<1286310944-25035-2-git-send-email-x0095840@ti.com>
	<AANLkTin+n8KsHz2jTtkbk2MnuiANrxpskThYU9FVu3CE@mail.gmail.com>
	<1287403590.2916.24.camel@atlantis.mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43219 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839Ab0JRMYe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Oct 2010 08:24:34 -0400
In-Reply-To: <1287403590.2916.24.camel@atlantis.mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@mindbit.ro>
Cc: Fernando Guzman Lugo <x0095840@ti.com>, gregkh@suse.de, felipe.contreras@nokia.com, ameya.palande@nokia.com, nm@ti.com, Hiroshi.DOYU@nokia.com, ohad@wizery.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, linux-omap@vger.kernel.org

On Mon, Oct 18, 2010 at 3:06 PM, Ionut Nicu <ionut.nicu@mindbit.ro> wrote:
> On Mon, 2010-10-18 at 01:36 +0300, Felipe Contreras wrote:
>> On Tue, Oct 5, 2010 at 11:35 PM, Fernando Guzman Lugo <x0095840@ti.com> wrote:
>> > Now the tidspbridge uses the API's from
>> > iovmm module.
>> >
>> > Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
>>
>> NAK. This patch doesn't work... I guess it's supposed to.
>>
>> So far I've found these errors, but it still doesn't work, maybe we
>> should start thinking of reverting the whole iommu stuff:
>
> I also tested it with the userspace-dspbridge tools and it doesn't work
> for me either.
>
> Maybe it's better to revert this patch series for now and re-submit it
> when all necessary patches get merged and it actually works on top of
> the staging-next tree?

I was thinking that rather than reverting it might make sense to have
configuration option to choose from one to the other. I'm trying to
minimize the changes on this patch to see what else I can catch, apply
the fixes on top of staging-next, and then add support for the old mmu
part, hopefully in a form that is similar to the current iommu.

-- 
Felipe Contreras
