From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/4] cpsw: support for control module register
Date: Thu, 22 Aug 2013 20:02:31 -0700 (PDT)
Message-ID: <20130822.200231.1289645477234890200.davem@davemloft.net>
References: <1377171448-27924-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1377171448-27924-1-git-send-email-zonque@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: zonque@gmail.com
Cc: netdev@vger.kernel.org, ujhelyi.m@gmail.com, mugunthanvnm@ti.com, vaibhav.bedia@ti.com, d-gerlach@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


Patch #3 doesn't apply to net-next because it makes changes to
a file "include/linux/platform_data/cpsw.h" which doesn't exist.
