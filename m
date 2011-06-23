From: "Grosen, Mark" <mgrosen-l0cyMroinI0@public.gmane.org>
Subject: RE: [RFC 0/8] Introducing a generic AMP/IPC framework
Date: Thu, 23 Jun 2011 16:27:10 +0000
Message-ID: <FFF198FBBF957F4393BA834040FEFFA202CA6E@DFLE35.ent.ti.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<4E033041.9090606@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4E033041.9090606-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
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
To: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: davinci-linux-open-source <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Brian Swetland <swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> From: Michael Williamson
> Sent: Thursday, June 23, 2011 5:23 AM
...
> I'd like to kick the tires on this with a da850 based platform (MityDSP-L138).
> Any chance you might be able to share the stuff you did on the remote side
> (DSP/BIOS adaptations for rpmsg,  utils for ELF or COFF conversion to
> firmware format, etc.) for the DSP side of your tests done with the
> hawkboard?

We have only implemented the remoteproc (load, start, stop) part for
OMAPL138 so far, i.e., not the rpmsg part (communications). I am not sure
when we will get to the rpmsg part.

We will be publishing a Git tree soon with the "remote processor" code under
a BSD license. This code works with our TI RTOS, SYS/BIOS (also BSD), on
both M3 and DSP CPUs. This will include the utility to generate the RPRC
firmware format from an ELF file. Note that the Linux side does not have any
explicit binding or dependency on the runtime environment on the remote
processor, so alternate RTOS or bare-metal implementations could also be
done. We will post a follow-up to the list with a URL soon.

> It looks like, at least for the da850, this subsumes or obsoletes
> DSPLINK in order to drive a more general purpose architecture
> (which looks great, so far, BTW).
> Is that the intent?

First, we are not abandoning DSPLINK. We have many users of this, even
though it is out-of-tree, and we will continue to support it. That said, we
do intend to make this new design the basis for DSPLINK-like
functionality. It's designed to be done "the right way" for Linux (and we
are looking for feedback to make it better).  It is also designed to be more
scalable and extensible in userspace. With a solid kernel foundation, we can
provide lots of functionality in userspace, or users can implement their own
custom solutions. One of the key things to do is map our existing DSPLINK
APIs, like MessageQ, to the new rpmsg transport.

Mark
