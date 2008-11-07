From: Paul Walmsley <paul@pwsan.com>
Subject: Re: 3430SDP crash at boot time
Date: Fri, 7 Nov 2008 05:00:18 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0811070458390.13920@utopia.booyaka.com>
References: <A24693684029E5489D1D202277BE894413A94881@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46117 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbYKGMAT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 07:00:19 -0500
In-Reply-To: <A24693684029E5489D1D202277BE894413A94881@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 6 Nov 2008, Aguirre Rodriguez, Sergio Alberto wrote:

> Today when I attempted to boot on an 3430SDP with latest commit, I got a kernel dump, which is this:

> PC is at cfi_qry_present+0x1c0/0x29c

f7429fd378a29cf6947c2613e0fd6e6e36165167 boots fine now on the 3430SDP 
ES2 that I use here.  What commit is your git head at, and what ES level 
is your 3430SDP using?


- Paul
