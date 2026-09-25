Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E798D3B8959
	for <linux-omap@vger.kernel.org>; Fri, 25 Sep 2026 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356903; cv=none; b=UBzaDfFGM+cpWhbBzZRdilxeoOKNq/dVtOkzNvExDmV7G3pKE6iCAcLQvD30pAijn3JnNdXF4r/dR6avHu4T0B1OklHwgUTTRUQvm4xCy8NySnhgC37N3OqntSqf6ssuhyL6n8I+KdtuU/LgRz9JLKV7JNMWgUmQnzBHil5Fe7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356903; c=relaxed/simple;
	bh=wUgsMiUfEK9Zu8BnQEf2g3A9P5+KDk4ZVGI5Lvg371E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdsXmwo1gM+oLjBWfWvL414gvx9w52u+jGeTvELRIAsCG7lqYuAmFsdef7SwmfsvRmWSW2uE4gczWUX6GTW7iHDA439ANXlzBhEIk2FPUF0t45wfWXYaor9ZYy0BEvYBAqrEG4VVmWt82aZ13n5uEFsifhxZVjGnn3mHGBEDNOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiDFcMex; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiDFcMex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE87E1F0089D
	for <linux-omap@vger.kernel.org>; Fri, 25 Sep 2026 17:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790356888;
	bh=XNmbr204Up7Ok7eGekStfLMb4Fdr9YmxqwJjaeRLmCE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PiDFcMexyMbCKloouvLH8Am+6+ow9b1XZ5UIbYgVrG+L11D9wRXlvEG8H8yng3+ua
	 GWkPZxa6YjvQy7KQ/4LrErDm2SKFGaquVXbsdDB2CPMwzrXwz2vlv2Wu0BjZNxmTo/
	 DttkYT6I1L7Tm9xirVO4vcDYZ2JMqSIkqf49FY+QnFdLenCVzqPeML0M6YskslCeQW
	 +LdikbC3uVuy5RL06sQadqsEu7LbbC4usCHoDlR9wS2bavdgfMlhTK1NC7PueN5PgA
	 QiGN64zH5ikJQ02El2TsDS+SrihBFPVBDeRlVm7/UhB3goEDsKWyuCL6WwbTCpgmD4
	 1xZaFcw72GuWQ==
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a652b710a5so6501281fa.3
        for <linux-omap@vger.kernel.org>; Fri, 25 Sep 2026 10:21:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy51N83+kdK7K6oRD8dtFhYyGrgixbg8GoiMKMEbNAMsvotftZ64/Ii8Ws3jxnNZVgPc+q55AD92TVy@vger.kernel.org
X-Gm-Message-State: AFuF++lTLfhEHpkjd+z12af03BYjFXXX5zL/ZDG91Qp50f6gDHKksuVp
	sujcIxiTYDhSrjQd4N11GYGGVLt1bRMt6O2KLUZoMeiy/mTLxdNdC/WNvhMOkJNsGJ1N25H4T53
	qfL5PkcAbbS1J3nV5uvKmeaJnnPuxAYE=
X-Received: by 2002:a05:651c:b0f:b0:3a3:749e:319e with SMTP id
 38308e7fff4ca-3a63de17ef3mr12978521fa.18.1790356887308; Fri, 25 Sep 2026
 10:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907064725.10686-1-hemanth.selam@gmail.com> <20260907064725.10686-6-hemanth.selam@gmail.com>
In-Reply-To: <20260907064725.10686-6-hemanth.selam@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 19:19:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gWh-owRUPvVFMakkvinrbquHsNDeTHFnxFsOXrbuUgjw@mail.gmail.com>
X-Gm-Features: AclHuK_ILwQGXShVI2J1hXJ11N9GyjGLgux8oszAP0m9LZ9ydGAWPgmg0ZIJt0M
Message-ID: <CAJZ5v0gWh-owRUPvVFMakkvinrbquHsNDeTHFnxFsOXrbuUgjw@mail.gmail.com>
Subject: Re: [PATCH 5/5] ACPI: NUMA: fix typo in log message
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, 
	Christian Loehle <christian.loehle@arm.com>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 8:48=E2=80=AFAM Hemanth Selam <hemanth.selam@gmail.c=
om> wrote:
>
> Correct the misspelling in a message the user sees, reported by
> scripts/checkpatch.pl using the list in scripts/spelling.txt.
>
> Only the message text changes, no code changes.
>
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>  drivers/acpi/numa/srat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 5c407dc6401e..f5616830f5a9 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -111,7 +111,7 @@ int __init fix_pxm_node_maps(int max_nid)
>                         for (j =3D 0; j <=3D max_nid; j++) {
>                                 if ((emu_nid_to_phys[j] =3D=3D i) &&
>                                     WARN(node_to_pxm_map_copy[j] !=3D PXM=
_INVAL,
> -                                        "Node %d is already binded to PX=
M %d\n",
> +                                        "Node %d is already bound to PXM=
 %d\n",
>                                          j, node_to_pxm_map_copy[j]))
>                                         return -1;
>                                 if (emu_nid_to_phys[j] =3D=3D i) {
> --

Applied as 7.4 material, thanks!
