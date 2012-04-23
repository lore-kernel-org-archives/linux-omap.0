From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCHv4 4/8] ARM: OMAP4: hwmod: flag hwmods/modules supporting
 module level context status
Date: Mon, 23 Apr 2012 10:52:45 -0500
Message-ID: <4F957ACD.2040103@ti.com>
References: <1334913591-26312-1-git-send-email-t-kristo@ti.com> <1334913591-26312-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58847 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752901Ab2DXOhO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Apr 2012 10:37:14 -0400
In-Reply-To: <1334913591-26312-5-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

Hi Tero,

On 04/20/2012 04:19 AM, Tero Kristo wrote:
> From: Rajendra Nayak <rnayak@ti.com>
> 
> On OMAP4 most modules/hwmods support module level context status. On
> OMAP3 and earlier, we relyed on the power domain level context status.
> Identify all such modules using a 'HWMOD_CONTEXT_REG' flag, all such
> hwmods already have a valid 'context_offs' populated in .prcm structure.

Is it necessary to add another flag? Can't we just check if context_offs
is non-zero? Would save adding a lot more lines to an already large file
:-)

Cheers
Jon
