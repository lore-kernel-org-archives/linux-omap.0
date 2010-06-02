From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [RFC] [PATCH v3 2/4] OMAP4: Keyboard device registration
Date: Wed, 2 Jun 2010 10:28:13 +0200
Message-ID: <20100602102813.59519b77@surf>
References: <27F9C60D11D683428E133F85D2BB4A53043E537F74@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043E537F74@dlee03.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
To: "Arce, Abraham" <x0066660@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Mon, 31 May 2010 16:44:52 -0500
"Arce, Abraham" <x0066660@ti.com> wrote:

> +	unsigned int length = 0, id = 0;
> +	int hw_mod_name_len = 16;
> +	char oh_name[hw_mod_name_len];
> +	char *name = "omap4-keypad";
> +
> +	length = snprintf(oh_name, hw_mod_name_len, "kbd");
> +
> +	oh = omap_hwmod_lookup(oh_name);
> +	if (!oh) {
> +		pr_err("Could not look up %s\n", oh_name);
> +		return -EIO;
> +	}

Maybe I'm missing something here, but I don't see where "length" is
being used, and why the snprintf()/oh_name thing is needed. What about:

	unsigned int id = 0;
	char *name = "omap4-keypad";

	oh = omap_hwmod_lookup("kbd");
	if (!oh) {
		pr_err("Could not look up kbd\n");
		return -EIO;
	}

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
