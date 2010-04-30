From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: [Query][omap iommu] Consulting iommu if a physical region is
 "mappable" before actually mapping it
Date: Fri, 30 Apr 2010 17:37:50 -0500
Message-ID: <A24693684029E5489D1D202277BE8944550BB017@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52102 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759903Ab0D3Whz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 18:37:55 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Hiroshi,

While still maintaining an old camera driver version, which
uses your latest iommu driver, we have come up with the following
question:

Can the iommu driver be "consulted" if a certain area (contiguous or not)
can be mapped or not, before even trying to do it?

The reason of this is that, in the camera driver case, we want to let
the user know if certain capture buffer area (that will be either allocated
in kernel or userspace) can be mapped later on without problems, which could
help the user don't even try to allocate the buffers, and avoid a trial-and-error
kind of cycle.

Is that possible with current driver? If not, how complex do you think it'll
be to implement that?

Regards,
Sergio
