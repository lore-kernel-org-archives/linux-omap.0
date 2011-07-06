From: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: RE: [RFC 5/8] remoteproc: add davinci implementation
Date: Wed, 6 Jul 2011 10:06:16 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D91A894@dbde02.ent.ti.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-6-git-send-email-ohad@wizery.com>
	<4E035B78.3080200@mvista.com>
	<FFF198FBBF957F4393BA834040FEFFA202D66E@DFLE35.ent.ti.com>
	<4E04A9AE.3030801@mvista.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D6C2F29@dbde02.ent.ti.com>
	<FFF198FBBF957F4393BA834040FEFFA202EC99@DFLE35.ent.ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D91A2CC@dbde02.ent.ti.com>
	<FFF198FBBF957F4393BA834040FEFFA2032F6F@DFLE35.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <FFF198FBBF957F4393BA834040FEFFA2032F6F-Jq/I0xf/SMGIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
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
To: "Grosen, Mark" <mgrosen-l0cyMroinI0@public.gmane.org>, Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, davinci-linux-open-source <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Brian Swetland <swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Mark,

On Tue, Jul 05, 2011 at 22:24:21, Grosen, Mark wrote:
> > From: Nori, Sekhar
> > Sent: Monday, July 04, 2011 10:35 PM
> > To: Grosen, Mark; Sergei Shtylyov
> 
> ...
> > > > Since procedure to set the boot address varies across DaVinci
> > > > platforms, you could have a callback populated in platform data
> > > > which will be implemented differently for original DaVinci and
> > > > DA8xx devices.
> > >
> > > I looked at DM6467 and it's the same as OMAPL13x, except at a
> > different
> > > address. Rather than a callback, it could be just an address in the
> > > platform data.
> > 
> > Sounds okay as long as _all_ the DaVinci devices have the same
> > bit to be set. Plus, I hope there are no other users of the
> > register so that there is no race with other platform code using
> > the same register.
> 
> Sekhar,
> 
> The register is a dedicated 32-bit register that holds the start/boot
> address for the DSP, so no other platform code should be using it. Once
> the LRST is de-asserted (via the PSC code enhancement), the DSP starts
> execution at the address in this register.

Okay. I had misunderstood this as a bit which is used to reset the DSP.
Thanks for clarifying.
 
Regards,
Sekhar
