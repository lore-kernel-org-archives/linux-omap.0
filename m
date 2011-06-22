From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC 7/8] drivers: introduce rpmsg,
	a remote-processor messaging bus
Date: Wed, 22 Jun 2011 12:12:33 +0930
Message-ID: <87liwu8u3q.fsf@rustcorp.com.au>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-8-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1308640714-17961-8-git-send-email-ohad@wizery.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, davinci-linux-open-source <davinci-linux-open-source@linux.davincidsp.com>, Arnd Bergmann <arnd@arndb.de>, Brian Swetland <swetland@google.com>, Grant Likely <grant.likely@secretlab.ca>, akpm@linux-foundation.org
List-Id: linux-omap@vger.kernel.org

On Tue, 21 Jun 2011 10:18:33 +0300, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Add a virtio-based IPC bus, which enables kernel users to communicate
> with remote processors over shared memory using a simple messaging
> protocol.

Wow, sometimes one writes a standard and people use it.  Thanks!

I'm still digesting exactly what you're doing, but this is a bit
unconventional:

> +	/* Platform must supply pre-allocated uncached buffers for now */
> +	vdev->config->get(vdev, VPROC_BUF_ADDR, &addr, sizeof(addr));
> +	vdev->config->get(vdev, VPROC_BUF_NUM, &num_bufs, sizeof(num_bufs));
> +	vdev->config->get(vdev, VPROC_BUF_SZ, &buf_size, sizeof(buf_size));
> +	vdev->config->get(vdev, VPROC_BUF_PADDR, &vrp->phys_base,
> +						sizeof(vrp->phys_base));

The normal way is to think of the config space as a structure, and use
offsets rather than using an enum value to distinguish the fields.

> +#define RPMSG_NAME_SIZE			32
> +#define RPMSG_DEVICE_MODALIAS_FMT	"rpmsg:%s"
> +
> +struct rpmsg_device_id {
> +	char name[RPMSG_NAME_SIZE];
> +	kernel_ulong_t driver_data	/* Data private to the driver */
> +			__attribute__((aligned(sizeof(kernel_ulong_t))));
> +};

This alignment directive seems overkill...

> +#define VIRTIO_ID_RPMSG		10 /* virtio remote processor messaging */

I think you want 6.  Plan 9 jumped ahead to grab 9 :)

Cheers,
Rusty.
