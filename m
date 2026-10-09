Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB523EB7E9;
	Fri,  9 Oct 2026 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791567276; cv=none; b=QvJJt9s19pF4uKigk0nbF28wVjlP+UhynRqwl6vvraTT1epdnkn3/m5jMrnL5VAOadn04/WWD43vFF1QrpeER/Kr8o4dv6pOoaByFuXzbmupC7C6K6oKEfvUqfsCJmK00kPeuwqyYgAlkFkPttmI/C+HoO5HRsWYQ/vw2kmj4dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791567276; c=relaxed/simple;
	bh=7JvhXxV1YuLLBfPgG9f3+Dy/RpnCeQIkzzy63OaQQSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgN2xvHoPvR1ZitGO9u3BlB8cTuaASogmwg2Bi7gyfW8QqaNqNejjBpYOMCWbGzpALBZc0NBJZ51R3URq9gV2cANHUXeQp5lq2k+Q0jNRXyE5Ma3uEcl4kOkiOjq042bXNg2VJC7vnlsWcmyMzHQxVgoywDsC4Smv5RMxk6xuyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOXVnO3z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOXVnO3z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457EC1F000FF;
	Fri,  9 Oct 2026 17:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791567275;
	bh=Y+e5fiagQUAbWq0G0G72uFDu9M2cjMIliK8S5C6avdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UOXVnO3zLoVszFvsV1E0D3WZpQXkBbOKbF5rRippK/RnbXOYcy3ELkYeimx3uG//V
	 CdFGVtMRcx7GLbDblh+dkr4XNWLvY/7MZtNA9aC/ABl8Q9d+7g5V6ZZ/tcQQgXUnpm
	 6W0tuTIBiq4UcdSPP0MZGUdO6pD/xWWMJnGcKnjgov9SfakkP43UUUt+cHr86DK8qb
	 taFrkhGfWcmDriSUwg2E0QCOewfSjpTMWVm5JsIzzRzHHJfKkkOcCWoSLHu++eImHK
	 4ZTJ+kzQ9OA+lPEbSGeDbuu5dOlAFZT3wb5CXE0C/ne2qxQNO0JoDukIkWjeatApNC
	 ljGhNLuwMZsGQ==
Date: Fri, 9 Oct 2026 12:34:33 -0500
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Quchaosheng <quchaosheng000406@163.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display: ti,tpd12s015: Convert to DT
 schema
Message-ID: <20261009173433.GA2862960-robh@kernel.org>
References: <20261009105601.301891-1-quchaosheng000406@163.com>
 <20261009105601.301891-2-quchaosheng000406@163.com>
 <20261009-2f34bbada2c463c78b2c05a7@squawk>
 <20261009144434.GD622105@killaraus.ideasonboard.com>
 <20261009-db35f1d74028d0d0a34f1106@squawk>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-db35f1d74028d0d0a34f1106@squawk>

On Fri, Oct 09, 2026 at 04:42:01PM +0100, Conor Dooley wrote:
> On Fri, Oct 09, 2026 at 04:44:34PM +0200, Laurent Pinchart wrote:
> > On Fri, Oct 09, 2026 at 03:25:49PM +0100, Conor Dooley wrote:
> > > On Fri, Oct 09, 2026 at 06:55:59PM +0800, Quchaosheng wrote:
> > > > From: Chaosheng Qu <quchaosheng000406@163.com>
> > > > 
> > > > Convert the TPD12S015 HDMI level shifter binding to DT schema.
> > > > 
> > > > The TI TPD12S015 is an HDMI companion chip that combines a level shifter
> > > > and ESD protection circuitry. Document the two ports it exposes between
> > > > the HDMI transmitter and the connector.
> > > > 
> > > > The tpd12s016 is software compatible with the tpd12s015 and is listed as
> > > > a fallback compatible by am57xx-idk-common.dtsi, so accept it as a
> > > > fallback of "ti,tpd12s015". The driver matches on "ti,tpd12s015" only, so
> > > > a board using the tpd12s016 must list both compatibles.
> > > > 
> > > > Assisted-by: LLM
> > > > Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
> > > 
> > > No idea if the sashiko reply is valid, because I have no clue if
> > > providing a subset of the gpios is functional. Really this should have
> > > multiple different gpios properties,

The minItems one is not valid. sashiko struggles on our quirks against 
normal json-schema. Generally, if either minItems or maxItems is not 
specified, we make them equal. I think I documented that, so we need to 
get sashiko to read it...

> > 
> > Definitely.
> > 
> > > but this binding is really old and
> > > not worth changing IMO.
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > pw-bot: not-applicable
> > 
> > I'm getting annoyed be the LLM-assisted individual conversions. Can we
> > start requiring people who convert text bindings to YAML to at least
> > handle whole groups in one go ? If they're going to do a bad job, I'd
> > rather have to review it once only.

I have a branch of ~600 questionable patches. :) It does make arm64 
warning free (and some of the warning fixes are valid).

What's left is really stuff that's old, not getting new platforms and no 
one cares about. I don't think we need perfection. We should probably 
just ignore sashiko.

> 
> Or do one, and take the learnings into all the remaining patches - but
> with LLM conversions I don't think there's really much learning going on
> at all.
> 
> I guess bunching them is fine, provided it is for one subsystem. I
> definitely don't want to see a set of 15 patches across 9 subsystems,
> at least with one subsystem it's likely to be the same common problems
> across the bunch.

I've tried expressing my preferences in priority, but it hasn't worked. 
It was mainly GSoC or other programs, but now it's?

My priority is:

- Fix arm64 warnings
- Fix arm warnings
- Convert subsystem bindings
- Fix other $arch warnings (no one cares AFAICT)

We're actually pretty close to arm64 being warning free. krzk's LPC 
slides inflate the numbers as N boards for a SoC give N copies of 
warnings. next is currently sitting at 218 warnings in my deduped count. 
About half of those are HiSilicon and Mediatek. The rest of the 
platforms (by subdir) are around ~20 or less.

arm32 is still a long way off. The recent platform removals should help 
though.

Rob
