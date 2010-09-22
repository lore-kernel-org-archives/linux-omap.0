From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [RFC v.4] omap: hwspinlock: Added hwspinlock driver
Date: Wed, 22 Sep 2010 10:10:19 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E5F57BFED@dlee03.ent.ti.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E1475D1B0F@dlee03.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E80AC50C@dbde02.ent.ti.com>
 <8F7AF80515AF0D4D93307E594F3CB40E4D79679E@dlee03.ent.ti.com>
 <AANLkTin3J6E8e5uTPoomfcpvP1+t4-Svuah3Mv6Nj1Fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58050 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753741Ab0IVPKV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 11:10:21 -0400
In-Reply-To: <AANLkTin3J6E8e5uTPoomfcpvP1+t4-Svuah3Mv6Nj1Fc@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "Basak, Partha" <p-basak2@ti.com>, "Que, Simon" <sque@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Ohad,

Sorry for the late response, was away from linux-omap mailing list last few days.
Please see my response.

> 
> It would probably make more sense to call pm_runtime_get_sync during
> hwspinlock_request{_specific}, and then call pm_runtime_put during
> hwspinlock_free.

I agree, this looks like a good approach.

Thank you,
Best regards,
Hari
