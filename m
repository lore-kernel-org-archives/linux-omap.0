From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH v2 0/2] OMAP2xxx EAC build fix and sparse cleanup
Date: Fri, 5 Sep 2008 10:00:35 +0300
Message-ID: <20080905100035.8ea24b79.jarkko.nikula@nokia.com>
References: <20080905054959.5272.63450.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:22076 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbYIEHCD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 03:02:03 -0400
In-Reply-To: <20080905054959.5272.63450.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

On Thu, 04 Sep 2008 23:50:48 -0600
"ext Paul Walmsley" <paul@pwsan.com> wrote:

> This series fixes a build bug in the EAC driver after the recent IO
> address changes, and resolves some sparse warnings.  Updated to use
> ioremap().
> 
> Compile-tested only.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> 
Thanks Paul. I tested these and plays fine (OS2007).

Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>
