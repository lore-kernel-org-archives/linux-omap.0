From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v11 2/4] PM / Domains: add setter for dev.pm_domain
Date: Mon, 11 Jan 2016 12:52:36 -0200
Message-ID: <CAOMZO5CuUede4=bvnx6+Fz6H1OSNaWpfm1ehNYyW9j5bCOODmg@mail.gmail.com>
References: <1445956731-6304-1-git-send-email-tomeu.vizoso@collabora.com>
	<CAAObsKC1jTzLWmMtwGWVStuMtzZwvMuA_731dsn4YX7aKMtFKQ@mail.gmail.com>
	<CAOMZO5A7p6iZTdnZtnzMPED1e7rPp=1Q9UiZ_598QNTWSL5jMw@mail.gmail.com>
	<2574144.OjYZBRkjZl@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2574144.OjYZBRkjZl@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Daniel Kurtz <djkurtz@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, Tomas Winkler <tomas.winkler@intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 11, 2016 at 12:45 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> OK, so does the appended patch help?

Yes, thanks. I do not see the warnings after 'reboot' with your patch applied:

Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
