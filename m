From: "Arce, Abraham" <x0066660@ti.com>
Subject: RE: [RFC] [PATCH v3 2/4] OMAP4: Keyboard device registration
Date: Wed, 2 Jun 2010 07:45:07 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E538AA1@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53043E537F74@dlee03.ent.ti.com>
 <20100602102813.59519b77@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20100602102813.59519b77@surf>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
List-Id: linux-omap@vger.kernel.org

Thanks Thomas,

> > +	unsigned int length = 0, id = 0;
> > +	int hw_mod_name_len = 16;
> > +	char oh_name[hw_mod_name_len];
> > +	char *name = "omap4-keypad";
> > +
> > +	length = snprintf(oh_name, hw_mod_name_len, "kbd");
> > +
> > +	oh = omap_hwmod_lookup(oh_name);
> > +	if (!oh) {
> > +		pr_err("Could not look up %s\n", oh_name);
> > +		return -EIO;
> > +	}
> 
> Maybe I'm missing something here, but I don't see where "length" is
> being used, and why the snprintf()/oh_name thing is needed. What about:
> 
> 	unsigned int id = 0;
> 	char *name = "omap4-keypad";
> 
> 	oh = omap_hwmod_lookup("kbd");
> 	if (!oh) {
> 		pr_err("Could not look up kbd\n");
> 		return -EIO;
> 	}

I'll remove length variable and keep snprintf, below oh_name -> kbd is used again, this will keep name defined in one single place

	WARN(IS_ERR(od), "Could not build omap_device for %s %s\n",
		name, oh_name);

Best Regards
Abraham
