From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH V6 0/4] cpuidle: Global registration of idle states with per-cpu statistics
Date: Thu, 22 Sep 2011 12:45:32 -0700
Message-ID: <87ty84tl7n.fsf@ti.com>
References: <20110922082840.10520.85895.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:52336 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753727Ab1IVTpi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 15:45:38 -0400
In-Reply-To: <20110922082840.10520.85895.stgit@localhost6.localdomain6>
	(Deepthi Dharwar's message of "Thu, 22 Sep 2011 13:58:52 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Cc: venki@google.com, ak@linux.intel.com, len.brown@intel.com, peterz@infradead.org, santosh.shilimkar@ti.com, arjan@linux.intel.com, lenb@kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Deepthi Dharwar <deepthi@linux.vnet.ibm.com> writes:

> The following patch series implements global registration of cpuidle
> states, and also has the necessary data structure changes to
> accommodate the per-cpu writable members of the cpuidle_states
> structure.

I reviewed earlier versions of the series, and this version still looks
good to me.  Any reason it is still RFC?

Reviewed-by: Kevin Hilman <khilman@ti.com>

and for the OMAP-specific parts,

Acked-by: Kevin Hilman <khilman@ti.com>

Kevin
