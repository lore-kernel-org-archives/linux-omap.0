From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] virtio: expose for non-virtualization users too
Date: Tue, 05 Jul 2011 15:35:46 -0700
Message-ID: <4E1391C2.2090904@zytor.com>
References: <1309874774-31689-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1309874774-31689-1-git-send-email-ohad@wizery.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Carsten Otte <cotte@de.ibm.com>, linux-ia64@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mips@linux-mips.org, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, Grant Likely <grant.likely@secretlab.ca>, Paul Mackerras <paulus@samba.org>, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Xiantao Zhang <xiantao.zhang@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>, Rusty Russell <rusty@rustcorp.com.au>, Chris Metcalf <cmetcalf@tilera.com>, John Stultz <john.stultz@linaro.org>, kvm-ppc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 07/05/2011 07:06 AM, Ohad Ben-Cohen wrote:
> virtio has been so far used only in the context of virtualization,
> and the virtio Kconfig was sourced directly by the relevant arch
> Kconfigs when VIRTUALIZATION was selected.
> 
> Now that we start using virtio for inter-processor communications,
> we need to source the virtio Kconfig outside of the virtualization
> scope too.
> 

Seems reasonable to me.

	-hpa
