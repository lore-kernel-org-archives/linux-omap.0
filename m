Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792426530;
	b=2la6sQSPsqsNx0SdjyB33ObLQ5DFj9mmLvaJaglvU/bOQ6E1Vjxk0wK0ZqZWT10g7u+8
	 A2lA866IaxFFf7SaOp009czHqCd4v4ILLu3RE9NA1vQ3LnxyJV++mRdw2u+f24ZlwcSsO
	 E0vp7uNYSW5CUH7D8IHX1ZMLm8M5u7STnoC8TDNH/x4X5aWMsW9dfhvZjslu8M6peFrHC
	 +3NsD2iMxy4lrR263QH6Juqn0jL7YzXxlUxSZfhecwD+6QtKAMPyC1b6ZON3SZgL55uif
	 VcHz4614f9EJrzLbZWdB2Fk40n1+c+RURihChCkBlChyv1va1NVJss+sxeguF1hknuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=sxvLHLonxAtIEKyDCtSl57PaQV0oEQBYciJAjgYjSho=;
	b=bllG7UGLgvz6qGJ+3AcO6BjoYu7cUczp+PcudrhRjGgm5GFHYze+aPH+GGFskyizBbzA
	 pv6/kup9lCYdUeT2zC0GR5hUC+RjK+dLk74XZMmCxCbJ+PT3xzYbFD0EdKcrbL1evVJTR
	 YrUt3mOZyLDXPaLBrU+TmzzdIW2U5/CzAHkjfRUPbZH6Q5i6liRyoQms9T/4e8nRrLZKe
	 zoTcvR/sa0gVrzcPkNAuAcQbBDHfb6A2jqouL3A3XIgWIseQ+uGc/XDLVxHQFqfgGutxt
	 QbHsMa4OjtwwkBSLl4gqAEiMbNLd7Nt5CTWxCEc+G2cMoKxO8yOF2cSBIfkZ0cHdBlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="TOeFQ6/Q";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.182
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E31606A31B
	for <linux-omap@vger.kernel.org>; Mon, 19 Oct 2026 16:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7E31606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TOeFQ6/Q
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3ab3b29a210so11388031fa.0
        for <linux-omap@vger.kernel.org>; Mon, 19 Oct 2026 09:15:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792426528; cv=none;
        d=google.com; s=arc-20260327;
        b=kLBvLeLfz9EY9NCMRzPOtwYZxuNLdsTCIw3fpp/u6+oLRu2dI2vLx0meoWm8pw8Coc
         XWywpg2tOGuj1hA8YQjiUJLdqwJbNFe/v4sP18TUJ8Ara31GYzN8fBn32mT9x3C5U/a0
         o3rlz1hlEft9zl69AbPc2MsDw5Lpcr4KUOmHz0hiSYs6dp4l5dG1mYF3zS+5E73/y2s3
         XWiPDM6A6VVt6l32CDL8yn7KhZio5OR//dB+zru2966KjXMewGduky+PK7kTeiBJrHgW
         /fT77Cb1j5PnHtTHSXfoYUfVQu5GQ5PcQ7nqbWSQ2QT+YGR4MLt8U4lKb56rbSREp1Xq
         U7MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=sxvLHLonxAtIEKyDCtSl57PaQV0oEQBYciJAjgYjSho=;
        fh=kQkqOJFIueQbRIOfD4DV98MoIstKLufy5ceZd6zoIuw=;
        b=qJrO7SxBjGTCsVsBPC8KiYmkJNheD/kpUUjXSNBbB8pElyJON+iKFm21xFDY4Ji69U
         hxJ2/fRalAAB4qy9JHDDkmqKaMhEz1veN5Xl7q+9GMq9/Kr2dmslTLmNyjcxFtHSEDgB
         Oz9K3SYRzHSWwOHxaAV21tmYW8OYC7EU2OXt5UEwuagK/qmD/l9Vh++5/OFRIbTr+Dz4
         Cjt4nlzIt7GL0cQdxsWSKEnG3s9vld9hLiskBcDLUXL8T8jlQhpvXkDHNMnmZsSbjYNa
         /xxmHi1dK7r+MYu7aa79C7hJT6SMRYb77p+TAq5pQRInqFnaBDJYrYB1ucHUZNefivH8
         /1Aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792426528; x=1793031328; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sxvLHLonxAtIEKyDCtSl57PaQV0oEQBYciJAjgYjSho=;
        b=TOeFQ6/QJpeBWUEPZkRvr+E9VSWcCyKCgCzjIrhc/wilmdHJzIX0lQYKxsDx5aUpEB
         IIKnAnIxxyD5WpzNgM+P5aQO69OEbk/QlYdScieuEgbARzUeAxNY9D87HP8doYoFMIcj
         WZ7GCdAaXOVTnpUv5yJX87AWWXTmNPo2So8avzr3TZRMgby6gWutUKfM9essXp96YDzp
         DQdJDECXXVw9uSArAEEK5SdyEEl9x+Xy4RZpL2LF0nAYcmU39j2KjkMcYU2SvYrfoVeL
         CeCutMLAEGdwk8UFJOMpT3UiXrZpvnB/f5rjaDK0eGUJAPjvEvlP0i/dhnx2R2Pnv0hf
         gUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792426528; x=1793031328;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sxvLHLonxAtIEKyDCtSl57PaQV0oEQBYciJAjgYjSho=;
        b=M6S1M1u5FZuordmark4ZSqWUB3sagkjWZiI54scAm/qJ5bsrHlOqxOtyNmBzrm/fCn
         k8Jxgc+i9s7qlMB+4Q4c7qLlvi8y5J1RfFDQA3XqqLgGHR6L/XL4VhfeebxtNZXqfsf5
         Om2mAfEYs/+JJDBOVM/UJhZkNkvPxS5JBGZjaXF0pAKt7KDIWV34m1LGIxnYom0A8GhC
         gDAx9/w6kEO/S4RN5aREItOXO0TDAv+XPdya3+TU7BHZrQWGqwiv4I5fzQlRvD0qW/uG
         mvpkvqicxwmoRuZ+N+cpBNEuMrR1M83+yNpOTvyrbmn2g+AxxxBq5WOlhrZiGSsPhLfb
         iPpQ==
X-Forwarded-Encrypted: i=1; AKwUvBxMlI19t/AR1Jjb/ON3rqsm6UX+R/wqeJyHRIQkb0wTfnpXFivDITh2OZrOh3tn7hFxgAUSNsd1GaiH@vger.kernel.org
X-Gm-Message-State: AFq9FYJOYibTpQH6OhwLrP8Elw//MCZTOn8GmfTPlVZA8pqViL9MUD6I
	Q76YodLQUMT+KrUTmud4y7l9htJkKwObWLjq8e8mzHRhuv+yGJY1QEVPTyj+NKBhs5yUqtVqfP6
	id9V9vjO8BToEQ6uapwDzNyMwGy/C6P7/5B4qoGIsDdJmaKcCyg==
X-Gm-Gg: AYBFou3xHwRGbbwEZDKJcKmHdcerlHbfWEnZrupSGn9PTwIN+x0jePxa1ljz/KfxkLl
	HN8u6c9xysaAii/VBfGyC2rOe+ePL0afA+lgDIOlziKRI1HZ7uEnH9r3DsDrMTL+X9KbV1XMs6X
	xSwhKJ9xzSWNJvPVxzeMJkxn8jYmgmE4rNx9W3n/Sx8wp3FsYdS50eJvRgdWyyV4AAL4CdfZeve
	1IGlQXX1UxmGO8F2niLdGqxQL8TOKzTEKjx64WXggjWRP/A7QL715A9ue8BkLbAlxIRqvexmAmp
	7L2J5C/6j5UI1KPZ7Gj0Bs7KOdUlB8NT9UiTxPsXT7flZ/1JzuphVnc=
X-Received: by 2002:a05:651c:893:b0:3a9:a197:c0c5 with SMTP id
 38308e7fff4ca-3ab147a7077mr23817611fa.11.1792426527597; Mon, 19 Oct 2026
 09:15:27 -0700 (PDT)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
Date: Mon, 19 Oct 2026 19:45:15 +0330
X-Gm-Features: AclHuK8NnwqmOakfIFnKy2pOOIHSjjLi5HhfMn_ExQtdiOinQoY-F4nrBSahe6k
Message-ID: <CAB_t1-ACDiUrXneHbqVy6GWcuCJqnQNdM0poRyrdv_y7G6TKzg@mail.gmail.com>
Subject: Re: [PATCH v4] usb: ohci-omap: implement overcurrent handling for
 GPIO-based power control
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[resending to the full list as requested]

Dear Mr. Kroah-Hartman,

You are right, I apologize. I should have replied to your v3 review
before sending v4. I was not familiar with the mailing list workflow
and will make sure to reply to review comments before sending new
versions in the future.

To address your v3 review points:

1. Lock: You were right that the spinlock was unnecessary. It was
   actually harmful =E2=80=94 gpiod_set_value_cansleep() sleeps during the
   I2C transfer to the TPS65010, so calling it under
   spin_lock_irqsave() was a bug. v4 removes the lock entirely and
   uses READ_ONCE/WRITE_ONCE instead.

2. Naming: Renamed overcurrent_status to overcurrent_active and
   overcurrent_changed to overcurrent_change_pending.

3. Include order: Fixed to be alphabetical.

4. Regarding the code origin: I did use an AI assistant to help me
   understand some of the kernel APIs (especially the OHCI hub status
   register layout and the gpiod subsystem) and to review my earlier
   versions for bugs. The code is mine, but I want to be transparent
   about the assistance.

I do not have the hardware to test this patch, so I cannot verify it
at runtime. Given that this is a legacy driver, I am happy to drop
this patch and work on something else if you think that would be
better. Otherwise, I can send a v5 addressing the Sashiko bot findings
(the IRQ handler ordering and the probe falling-edge race).

Please let me know how you would like to proceed.

Best regards,
Muhammad Mahdi Amirpour
