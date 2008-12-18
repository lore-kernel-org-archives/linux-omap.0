From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [ANNOUNCE] updated PM branch
Date: Thu, 18 Dec 2008 02:52:04 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0812180251160.24916@utopia.booyaka.com>
References: <87k5a098zd.fsf@deeprootsystems.com> <87myeu1whz.fsf@deeprootsystems.com> <764864D8-4A22-44B9-ABF2-42664AC6583D@student.utwente.nl> <494990DC.5080407@deeprootsystems.com> <A6D1DEDA-DBA9-44A6-A879-F26A5C44D3B1@student.utwente.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34464 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbYLRJwG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2008 04:52:06 -0500
In-Reply-To: <A6D1DEDA-DBA9-44A6-A879-F26A5C44D3B1@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Thu, 18 Dec 2008, Koen Kooi wrote:

> I suspected  the 80mA drop was a bit much for just putting the DSS system into
> sleep, hence my gpio suggestion :) Thanks for confirming it.

The next interesting question for Beagle is: what else could be consuming 
the 80mA, if not the DVI framer?


- Paul
