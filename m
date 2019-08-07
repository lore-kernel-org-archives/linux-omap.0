From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 0/3] bus: ti-sysc: fixes for reset handling
Date: Wed, 7 Aug 2019 15:46:02 +0300
Message-ID: <1565181965-21039-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, s-anna@ti.com
Cc: linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Here are a few patches to fix reset handling for ti-sysc bus driver.
Without these, the iommu won't be working properly at least.

-Tero

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
