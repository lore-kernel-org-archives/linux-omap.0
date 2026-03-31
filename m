Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72D8194C98
	for <linux-omap@vger.kernel.org>; Tue, 31 Mar 2026 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774947549; cv=none; b=MZjTnDVtvxJszVezlLWc8Hn+zBTf5r3fX7L0pjIRhGvbQUiF37GSHfH3Z45aWS8L5MprpRQhZ1lkdUw0y/7rEMJhoII8VDWyNP9Le+f4RgKZp3o/HDVDBl32x8PlM0UkSSr+TNN4FWWaiGlrLKZBZ9OC+Dbzsxx+hWvyt/Fhpe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774947549; c=relaxed/simple;
	bh=IYGobMEXU13zxFV94JS8/SK88BkSPNQBTubyddj5Owk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEbKfGOeCdllVHT48Cd24RZltitPuNYjH/hj6ADCN4/GjDJzaLgsaV9wUthLmnItu/HSL7j9Xu4X/L9WekBnNSl3c9MS+aPkssKoJEvcgwxAhEG3fgCn+ESdW9z+Z4AiGfxrrXkzUzbGwQK7mvREeFTjZYaGD1GRhlGdMZnxsZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGmq4onR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGmq4onR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874DAC2BCB0
	for <linux-omap@vger.kernel.org>; Tue, 31 Mar 2026 08:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774947549;
	bh=IYGobMEXU13zxFV94JS8/SK88BkSPNQBTubyddj5Owk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JGmq4onRjzaV5h7DDEpYNFw0IK/0JsivWpE6ODmyTBf7wNGUo3rFHRFRw90gAFgZW
	 IGxaEi2XTGciKsZQCP3ZMgk6uh6IFJq8QYN2X/4ZmGj//jbaHCyjBpj7nseP71ms4R
	 c/VW+9CDdGQfYi5TgudkKNgkCoQXINArPhD0FaJpHeouZ/wGlAD6kYemj/Fg6BgLYp
	 5+D3bf/q4bUF0Pr/r6Wz5YWdg07Xi/zOJhTtcRMyCDeKtmumiqAFD5Vtbd7pN7mjBa
	 5Q6RfXVbwjj0F9WYidHi6OA/xLlmnWJSsXkAGAfh+tyQhV6OJ7pltYzzvXNbAFJtdl
	 BJg0+8DiVSSBQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38cb6a44d3dso3693761fa.2
        for <linux-omap@vger.kernel.org>; Tue, 31 Mar 2026 01:59:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLr2e69JL7148WNLMO3ZBJnvosjOD1JgM9DQQ5eSH4LjzLZjlFw10nDnQCcb+U2sOTQpoPI8810OON@vger.kernel.org
X-Gm-Message-State: AOJu0YyuLgTJWXUyt0D4ypB3sakOq7EhutWc2jQ4xnsdYBejpTkMFz1d
	VKIdFQ3+ZvqDe3pB+gRrnG//llX631jJgTe/cCWrmaLN4Yu1h4DJWkOOswOqG2JrLKe+JqFkOqg
	tCVHCNW3Fu7tKv0AgmAeoXHGDMSiiz7f6F7xLpGZdzg==
X-Received: by 2002:a2e:a593:0:b0:38a:8602:71aa with SMTP id
 38308e7fff4ca-38c731af9acmr51553271fa.16.1774947548197; Tue, 31 Mar 2026
 01:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-nokia770-gpio-swnodes-v4-0-b68592e977d0@oss.qualcomm.com>
 <20260330-nokia770-gpio-swnodes-v4-2-b68592e977d0@oss.qualcomm.com>
 <acrcDTPpXZ_5A4D8@ashevche-desk.local> <acruxMNdnUlyRHiy@google.com>
 <acto3TE1AR8iTzF0@ashevche-desk.local> <DDF494E5-C188-4A86-AC02-265B6169B591@gmail.com>
 <acuMD7Oly4XWW4n8@ashevche-desk.local>
In-Reply-To: <acuMD7Oly4XWW4n8@ashevche-desk.local>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 31 Mar 2026 10:58:55 +0200
X-Gmail-Original-Message-ID: <CAMRc=Md-eJW4NUo7cVGDArg_MO53vfueHVqCzxrfUWJ5-MGjng@mail.gmail.com>
X-Gm-Features: AQROBzC64iVV0opSN20lxil0szzNnss6IuetV8sn6EmP7LsMeDIFMQJ351z-AI4
Message-ID: <CAMRc=Md-eJW4NUo7cVGDArg_MO53vfueHVqCzxrfUWJ5-MGjng@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] driver core: make software nodes available earlier
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Kevin Hilman <khilman@baylibre.com>, 
	Arnd Bergmann <arnd@arndb.de>, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 10:55=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Mar 30, 2026 at 11:52:34PM -0700, Dmitry Torokhov wrote:
> > On March 30, 2026 11:25:33 PM PDT, Andy Shevchenko <andriy.shevchenko@l=
inux.intel.com> wrote:
> > >On Mon, Mar 30, 2026 at 02:46:45PM -0700, Dmitry Torokhov wrote:
> > >> On Mon, Mar 30, 2026 at 11:24:45PM +0300, Andy Shevchenko wrote:
> > >> > On Mon, Mar 30, 2026 at 02:40:47PM +0200, Bartosz Golaszewski wrot=
e:
>
> ...
>
> > >> > > -static void __exit software_node_exit(void)
> > >> > > -{
> > >> > > -      ida_destroy(&swnode_root_ids);
> > >> > > -      kset_unregister(swnode_kset);
> > >> > >  }
> > >> > > -__exitcall(software_node_exit);
> > >> >
> > >> > Why? What's wrong with the __exitcall?
> > >>
> > >> It's dead code. Always was, always will be.
> > >>
> > >> Maybe split in a separate patch, but I sometimes feel the idea of "o=
ne
> > >> change" is taken to extreme and adds to both developer's and maintai=
ners
> > >> burden by needing to keep track of extra patches.
> > >
> > >Why does __exitcall() exist then? It's also used in other places.
> > >I think it's generally good to have a possibility to clean up
> > >after run.
> >
> > The code section will be discarded when the kernel finishes booting so =
it
> > only increases image size on disk.
>
> Almost true. Interesting microblaze case, where it's not discarded.
> But I can't find where it's actually used on any architecture.
>
> > >A bit of archaeology:
> > >
> > >The first time it appeared was in the bcc2152647b8 ("Import 2.4.0-test=
3pre3").
> > >Then somehow spread a bit (but not much).
> >
> > And it shows how useful it is. Maybe it had some purpose a long time ag=
o, but
> > at present time this code will never be executed since it cannot be bui=
lt as
> > a module.
>
> Are you sure about definition of __exitcall? As I read init.h the macro
> is defined when it's not a MODULE.
>
> Anyways, if we going to drop that, it should be in a separate change
> explaining all these.
>

Sure. We must drop it too because the initialization no longer happens
in an initcall but is called from elsewhere so - were it not dead code
- we could end up with it being called before the init function.

Bart
