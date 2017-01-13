From: Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH 07/37] PCI: dwc: designware: Get device pointer at the
 start of dw_pcie_host_init
Date: Fri, 13 Jan 2017 17:22:44 +0000
Message-ID: <fbfa32a8-0897-9c8a-618c-bb41fa26c532@synopsys.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-8-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1484216786-17292-8-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
Cc: devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


Hi!

=C0s 10:25 AM de 1/12/2017, Kishon Vijay Abraham I escreveu:
> No functional change. Get device pointer at the beginning of
> dw_pcie_host_init instead of getting it all over dw_pcie_host_init.
> This is in preparation for splitting struct pcie_port into host and
> core structures (Once split pcie_port will not have device pointer).
> =


I think change should be condense with another patch to reduce the patch-set
number and to give it real meaning. I understand why you are breaking so mu=
ch
the patch, it is has a lot of changes, but in my opinion is too much fragme=
nted.

Thanks
Joao
