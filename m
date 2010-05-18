From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Tue, 18 May 2010 09:03:08 +0200
Message-ID: <4BF23BAC.90102@euromail.se>
References: <1272667021-21312-1-git-send-email-arve@android.com>	
	<87wrvl5479.fsf@deeprootsystems.com>	
	<20100503180741.GB2098@rakim.wolfsonmicro.main>	
	<201005032318.35383.rjw@sisk.pl>
	<87sk68r1zh.fsf@deeprootsystems.com>	
	<s2qd6200be21005031709r28420f0ezf3cf286517ee9114@mail.gmail.com>	
	<alpine.DEB.2.00.1005141422110.3348@utopia.booyaka.com>	
	<AANLkTinyNYFwM4QJKPunlvK-ATJwSYVXGayeZIR9izx2@mail.gmail.com>	
	<alpine.DEB.2.00.1005172018380.27473@utopia.booyaka.com>
	<AANLkTinOFSVHnufbVKIei0KMbfkVvDgLVDRHkCldagfY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinOFSVHnufbVKIei0KMbfkVvDgLVDRHkCldagfY@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Sven Neumann <s.neumann@raumfeld.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tero Saarni <tero.saarni@gmail.com>, linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Alexey Dobriyan <adobriyan@gmail.com>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Daniel Mack <daniel@caiaq.de>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, =?ISO-8859-1?Q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Brian Swetland <swetland@google.com>
List-Id: linux-omap@vger.kernel.org

Arve Hj=F8nnev=E5g wrote:
> It does not matter how you enter suspend. Without opportunistic
> suspend, once you tell the kernel that you want to suspend, you cannot
> abort. If a wakeup event occurs at this point, it will probably not be
> processed until the system wakes up for another wakeup event.
> =


Since it seems to be at the very core of the argument, how long time does it
take to suspend your system? Is it something that could be improved upon?

Henrik
