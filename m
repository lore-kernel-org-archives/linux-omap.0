From: "Grosen, Mark" <mgrosen-l0cyMroinI0@public.gmane.org>
Subject: RE: [RFC 1/8] drivers: add generic remoteproc framework
Date: Mon, 27 Jun 2011 21:52:30 +0000
Message-ID: <FFF198FBBF957F4393BA834040FEFFA202EE00@DFLE35.ent.ti.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-2-git-send-email-ohad@wizery.com>
	<20110627204958.GB20865@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20110627204958.GB20865-e0URQFbLeQY2iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: davinci-linux-open-source <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Brian Swetland <swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> From: Grant Likely
> Sent: Monday, June 27, 2011 1:50 PM

Grant, thanks for the feedback. I'll try to answer one of your
questions below and leave the rest for Ohad.

Mark
 
> > +Every remoteproc implementation must provide these handlers:
> > +
> > +struct rproc_ops {
> > +	int (*start)(struct rproc *rproc, u64 bootaddr);
> > +	int (*stop)(struct rproc *rproc);
> > +};
> > +
> > +The ->start() handler takes a rproc handle and an optional bootaddr
> argument,
> > +and should power on the device and boot it (using the bootaddr
> argument
> > +if the hardware requires one).
> 
> Naive question: Why is bootaddr an argument?  Wouldn't rproc drivers
> keep track of the boot address in their driver private data?
 
Our AMPs (remote processors) have a variety of boot mechanisms that vary
across the different SoCs (yes, TI likes HW diversity). In some cases, the
boot address is more like an entry point and that comes from the firmware,
so it is not a static attribute of a driver. Correct me if I misunderstood
your question.

Mark
