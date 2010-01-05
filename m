From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 4/4] OMAP clock/CPUFreq: avoid leaking the CPUFreq
 frequency table
Date: Tue, 5 Jan 2010 12:46:03 +0200
Message-ID: <20100105104603.GB11291@nokia.com>
References: <20100105024113.16275.96273.stgit@localhost.localdomain>
 <20100105024207.16275.26135.stgit@localhost.localdomain>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:49074 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab0AEKs4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 05:48:56 -0500
Content-Disposition: inline
In-Reply-To: <20100105024207.16275.26135.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Jan 05, 2010 at 03:42:08AM +0100, ext Paul Walmsley wrote:
>OMAP2xxx uses a dynamically-allocated cpufreq_frequency_table array,
>so this patch ensures that it is freed if CPUFreq terminates.

wasn't this introduced by the previous patch ?

-- 
balbi
