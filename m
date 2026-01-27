Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4573587CA;
	Tue, 27 Jan 2026 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521080; cv=none; b=t03YDcJYFfz2Qhvi/W4Uy4JJBa3bXyZoYMA6fB6RvEPB9ljC/HymA6Cs4tg71JMIe42pf9TIWppkwTz1DkVcelMxFyjWsjGFpdJ4wJKyuw/xP5qHC2OaVSGw+4yz8fREy41RrMxa9BtKkVwm4mWfqtG42Y+TZt/Gq9O1BiBr1Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521080; c=relaxed/simple;
	bh=2o9XeiaV+pV1m7JV1xysf2I4EcAw0dYDb9YlHz6XTow=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=W/pO+EQWBYXqFa83z+BzslmW6XqF0KHrugsB5bMLS7OutDaFCf7xXvVvVKnyX3Qah5Bp5mHVnZbgnr2/FCtSxKRPopl43Uj3fNKsg5sD78ykgs+OFdUQgg0sBT0KBZQFezhbOljzJ3TprMaz8AskPBxgLedxC/7kF02eFYwBNv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChYnVqwN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChYnVqwN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B4FC116C6;
	Tue, 27 Jan 2026 13:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769521080;
	bh=2o9XeiaV+pV1m7JV1xysf2I4EcAw0dYDb9YlHz6XTow=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=ChYnVqwNpVDugUrDdZgiGSiXdpOB0lzmvSQTNGypGi9uSB345QwCpeKyVwh9JSLZ2
	 AtEWFMU+ZdO1LWnJcYviWH+/EOsMuvd/CZ9SnSN1rRfoKs2pEcCW6yqN+ghPaYruB0
	 ItHkeVaB0IfHSUAISyujeJK6wqhgZf3cEVkoSmya58enc46jl42+5rPcLKCAUoo+j6
	 wAJwHH1bauMxKo+A3UkqYtlrT3bMZxikAGkSSKG5jUEbcFF2wq0fZSR18dedAuRa2y
	 4+WiJesTIjwS5c+mZwR61h+eOUuHvWj6p2TNA4OpFrBJkMzQBMxTilE5BVRWBxG9Su
	 747+EvnFVdMwg==
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jan 2026 14:37:55 +0100
Message-Id: <DFZEVBSZTGK8.2227V5O5GQS9T@kernel.org>
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] gpio: omap: do not register driver in probe()
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <broonie@kernel.org>,
 <will@kernel.org>, <grygorii.strashko@ti.com>, <ssantosh@kernel.org>,
 <khilman@kernel.org>, <linusw@kernel.org>, <brgl@kernel.org>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-gpio@vger.kernel.org>
References: <20260123133614.72586-1-dakr@kernel.org>
 <176950495232.13307.15142034347404555496.b4-ty@oss.qualcomm.com>
In-Reply-To: <176950495232.13307.15142034347404555496.b4-ty@oss.qualcomm.com>

On Tue Jan 27, 2026 at 10:09 AM CET, Bartosz Golaszewski wrote:
> Applied, thanks!
>
> [1/1] gpio: omap: do not register driver in probe()
>       commit: 3cb53b083fa665ec14c52962f50b9c1df48cf87b

I think you missed to pick up the diff in [1]. Please let me know if you wa=
nt a
fixup patch for this.

(One unrelated note, just be because I noticed by accident. Your applied pa=
tches
seem to use https://lore.kernel.org for Link: tags, while it has been agree=
d to
use https://patch.msgid.link instead [2].

I just mention it since it might be unintentional, i.e. it might be that yo=
ur
tooling does not consider it.

Personally, I use b4 and have the following in my .gitconfig:

	[b4]
		linkmask =3D https://patch.msgid.link/%s

Not sure this is still necessary in the latest version though.)

[1] https://lore.kernel.org/all/DFW0SC4QG4W8.C7BRHX02W3IK@kernel.org/
[2] https://lore.kernel.org/all/CAHk-=3Dwj5MATvT-FR8qNpXuuBGiJdjY1kRfhtzuyB=
SpTKR+=3DVtw@mail.gmail.com/
