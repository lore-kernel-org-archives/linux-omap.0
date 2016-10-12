From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 05/11] pci: rename *host* directory to *controller*
Date: Wed, 12 Oct 2016 05:43:15 -0700
Message-ID: <20161012124315.GC942@infradead.org>
References: <1473829927-20466-1-git-send-email-kishon@ti.com>
 <1473829927-20466-6-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1473829927-20466-6-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: devicetree@vger.kernel.org, Joao.Pinto@synopsys.com, Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org, Joao Pinto <jpinto@synopsys.com>, Jingoo Han <jingoohan1@gmail.com>, Pratyush Anand <pratyush.anand@gmail.com>, nsekhar@ti.com, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, hch@infradead.org, m-karicheri2@ti.com, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org, mingkai.hu@nxp.com
List-Id: linux-omap@vger.kernel.org

This is a big and painful change.  I'd suggest to either drop it for
now or convince Bjorn to take it as a scripted renamed just after -rc1.
