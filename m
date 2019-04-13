From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3 24/26] PCI: designware-ep: Use aligned ATU window for
 raising MSI interrupts
Date: Sat, 13 Apr 2019 10:58:04 -0500
Message-ID: <20190413155804.GH126710@google.com>
References: <20190325093947.32633-1-kishon@ti.com>
 <20190325093947.32633-25-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190325093947.32633-25-kishon@ti.com>
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
Cc: devicetree@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Minghuan Lian <minghuan.Lian@nxp.com>, Murali Karicheri <m-karicheri2@ti.com>, linux-arm-kernel@axis.com, Jingoo Han <jingoohan1@gmail.com>, Mingkai Hu <mingkai.hu@nxp.com>, linux-omap@vger.kernel.org, Roy Zang <roy.zang@nxp.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 25, 2019 at 03:09:45PM +0530, Kishon Vijay Abraham I wrote:
> Certain platforms like K2G reguires the outbound ATU window to be

s/reguires/require/ (note two changes: "g->q" and drop s)
