From: Komal Shah <komal_shah802003@yahoo.com>
Subject: RE: [PATCH] Alsa modularisations and support for tsc2101 4/7
Date: Tue, 21 Feb 2006 06:14:24 -0800 (PST)
Message-ID: <20060221141424.95300.qmail@web32914.mail.mud.yahoo.com>
References: <520AB2AD990DC04082102F77CA1726381036EC@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <520AB2AD990DC04082102F77CA1726381036EC@dlee03.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Menon, Nishanth" <x0nishan@ti.com>, Daniel Petrini <d.pensator@gmail.com>, OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

--- "Menon, Nishanth" <x0nishan@ti.com> wrote:

> 
> One interesting observations about the new platform device support.
> on SDP2430, we can plug in the codec we'd desire. the combination of
> codec and mcbsp settings are useful, not mcbsp settings remaining
> remaining constant.
> 
> i can see we can do it here and a lot cleaner :)

I am not able to understand this. Could you please explain?

Does it mean, that you have added the code in 2430 port which does
above stuff, means dynamic setting for McBSP from platform data? _or_
You want to mention that McBSP settings for particular board and codec
combination remains same.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
