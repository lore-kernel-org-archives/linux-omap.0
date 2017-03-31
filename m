From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 14/24] dt-bindings: mfd: syscon: Add documentation for
 #syscon-cells property
Date: Fri, 31 Mar 2017 14:06:27 -0500
Message-ID: <20170331190627.nucviejokdklgtk7@rob-hp-laptop>
References: <20170327094520.3129-1-kishon@ti.com>
 <20170327094520.3129-15-kishon@ti.com>
 <20170331185852.mxa4gvjxbuxl65dq@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170331185852.mxa4gvjxbuxl65dq@rob-hp-laptop>
Sender: linux-pci-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hch@infradead.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 31, 2017 at 01:58:52PM -0500, Rob Herring wrote:
> On Mon, Mar 27, 2017 at 03:15:10PM +0530, Kishon Vijay Abraham I wrote:
> > Add documentation for the optional #syscon-cells property to determine
> > the number of cells that should be given in the phandle while
> > referencing the syscon-node.
> > 
> > Suggested-by: Rob Herring <robh@kernel.org>
> 
> I did? When?
> 
> I'm not remembering why we need this. Generally, phandles to a syscon 
> are for a single defined purpose. When do we need a list of them?

Ah, I remember now the context. I suggested using standard parsing 
function rather than open coding. I wasn't suggesting changing the 
binding. Instead of of_parse_phandle_with_args, can't 
of_parse_phandle_with_fixed_args work?

Rob
