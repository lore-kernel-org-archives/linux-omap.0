From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] memory: omap-gpmc: Use of_node_name_eq for node name
 comparisons
Date: Tue, 11 Dec 2018 08:28:30 -0800
Message-ID: <20181211162830.GS6707@atomide.com>
References: <20181205195050.4759-14-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181205195050.4759-14-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh@kernel.org> [181205 11:51]:
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
> 
> For instances using of_node_cmp, this has the side effect of now using
> case sensitive comparisons. This should not matter for any FDT based
> system which this is.

Applying into omap-for-v4.21/driver thanks.

Tony
