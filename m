From: Paul Walmsley <paul@pwsan.com>
Subject: Question about tracing in _pwrdm_state_switch()
Date: Sun, 29 Jan 2012 03:08:46 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201290302480.27331@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49605 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab2A2KIr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Jan 2012 05:08:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jpihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, t-kristo@ti.com, khilman@ti.com, rnayak@ti.com, santosh.shilimkar@ti.com


Hi Jean

Quick question on the tracing in _pwrdm_state_switch().

That section of the code reads:

	state = pwrdm_read_pwrst(pwrdm);

...

	case PWRDM_STATE_PREV:
		prev = pwrdm_read_prev_pwrst(pwrdm);
		if (pwrdm->state != prev)
			pwrdm->state_counter[prev]++;
		if (prev == PWRDM_POWER_RET)
			_update_logic_membank_counters(pwrdm);
		/*
		 * If the power domain did not hit the desired state,
		 * generate a trace event with both the desired and hit states
		 */
		if (state != prev) {
			trace_state = (PWRDM_TRACE_STATES_FLAG |
				       ((state & OMAP_POWERSTATE_MASK) << 8) |
				       ((prev & OMAP_POWERSTATE_MASK) << 0));
			trace_power_domain_target(pwrdm->name, trace_state,
						  smp_processor_id());
		}

This code is called after returning from WFI.  It appears to compare the 
powerdomain's current power state ('state') with the powerdomain's 
previous power state ('prev').  But it appears to me that it should 
instead compare the powerdomain's intended power state ('pwrdm->state') 
with 'prev' ?  The rationale is that the PRCM could have brought that 
powerdomain up to a higher power state than 'pwrdm->state' during the 
wakeup process.

What do you think?


- Paul
