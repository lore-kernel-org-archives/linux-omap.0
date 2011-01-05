From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v3 12/17] OMAP2,3: DSS2: RFBI Move init,exit to driver
Date: Wed, 05 Jan 2011 17:46:30 +0200
Message-ID: <1294242390.14254.147.camel@tubuntu>
References: <1294059069-26737-1-git-send-email-svadivu@ti.com>
	 <1294059069-26737-13-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-da02.ext.nokia.com ([147.243.128.26]:60121 "EHLO
	mgw-da02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958Ab1AEPqh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 10:46:37 -0500
In-Reply-To: <1294059069-26737-13-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Guruswamy Senthilvadivu <svadivu@ti.com>, "ext Semwal, Sumit" <sumit.semwal@ti.com>
Cc: paul@pwsan.com, khilman@deeprootsystems.com, v-hiremath@ti.com, a0919096@ti.com, linux-omap@vger.kernel.org

On Mon, 2011-01-03 at 18:21 +0530, ext Guruswamy Senthilvadivu wrote:
> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> For hwmod adaptation, move init exit methods from core.c to its driver probe,
> remove.  pdev member has to be maintained by its own drivers.  Replace printk
> with dev_dbg for boot time optimization.

Changing the printk to dev_dbg is a separate change. This is also done
in the following patches. When moving code, never do any changes to the
code being moved if not absolutely necessary.

The version printks could be all put to one patch, which would change
them for all components.

 Tomi


