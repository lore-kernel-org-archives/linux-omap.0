From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [RFC PATCH V6 0/4] cpuidle: Global registration of idle states
 with per-cpu statistics
Date: Thu, 22 Sep 2011 10:35:22 -0700
Message-ID: <4E7B71DA.90909@linux.intel.com>
References: <20110922082840.10520.85895.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26063 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768Ab1IVRf1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 13:35:27 -0400
In-Reply-To: <20110922082840.10520.85895.stgit@localhost6.localdomain6>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Cc: khilman@ti.com, venki@google.com, ak@linux.intel.com, len.brown@intel.com, peterz@infradead.org, santosh.shilimkar@ti.com, lenb@kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 9/22/2011 1:28 AM, Deepthi Dharwar wrote:
> The following patch series implements global registration of cpuidle
> states, and also has the necessary data structure changes to
> accommodate the per-cpu writable members of the cpuidle_states
> structure.
>


you can consider this series Acked-by: Arjan van de Ven 
<arjan@linux.intel.com>
it's a good simplification of the code, and unlike frequencies, idle 
states are really shared between all cpus for
very practical reasons.

