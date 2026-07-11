Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00353C3451
	for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783788509; cv=none; b=YnZdTm8nWRL5sDewAe/fXpqXR5EN2tvAncGMkSzzCGS3eZtik3VtvtP9phHLgwr8z2MtEPvqjCuHsGTCBltnL0FxN1Hfgzhr6OWEM6sk3NNICJzvzBUtZX0ug4Pe6+WXEPrYs0DG2exEpi/rsMlAkA1+vN5I2RgryXvZxm/lvaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783788509; c=relaxed/simple;
	bh=BoQT9QyuvDPpf+Uz0OcP4BBhhJPSPS/TOn7RXbZ0l5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GVrd/DpbqeTYJpYfFF2r6ufmZpXNS76ZDVQLb5CLJE65v0qSiJbsloR+eC7uoaPKd1tipU5+x1DlTDrqNA/MwGkt5/9YUHIsbA5y68jr7bkD77SR6BGA8IhDPUTI1Ey5JF9uYeg6VdsWs5pFIq44NWGh9FfRTZAHT7mWCJKEEd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oVuzYuUV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVuzYuUV"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493d92b7db3so19379305e9.2
        for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 09:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783788505; x=1784393305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kenkJqSu0B0lVB8IF1SD7uLqT70NJDzMSzBH90/RAac=;
        b=oVuzYuUVbSemE2H8FzJH0zzDi63CXBKOA/+oMXsRWef5MyujD9q+rOrqzd+ozrD4zw
         ZAtepYmj0GI4CYzOMfmjpWfpQhvuO9A+W/ZStuVTakuyiNVx1ePPIm5L/46hm49AMQOH
         P44UBXeVNo63DsTZjKM2tQnn+pLOh5GPCormcE+s0HlGS2/Brz8+3moc7LRuiXHTQBZo
         64qFt/wW7oU/GAh+amXlKR3Vb108v1WeEHPbagx+mai9Uho0L8AuBr8KD7nVRT3uiMw3
         +MSxT2J9fL106v6wknSukeB3FXaPFmGpcaanVDIpxrr7BRDIzZRrwHs+YZftWQQPzzco
         Ya4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783788505; x=1784393305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kenkJqSu0B0lVB8IF1SD7uLqT70NJDzMSzBH90/RAac=;
        b=AWLodKb+rWqp+ZurwhVkMW+Wy9wpfI5Gcm80I0t31WMW7pavHjkG0YJxbg+KGrz4Y+
         n9upstt+ihL1KzDhXu6i/Wsa8BEf+0+TS6cCEBa/j5Jshn9pYEQ78ohZG8Nf8bOp6XVX
         3eUXij/t7VSEV4OMRTXQBhFOtPqC2LzE+BuyrTLJA7FH7W6kzIcSC8YAYUBihzsQLB1y
         2FeO7ksIsASnpfeq0mvwrQLvBwI+e6wFynxqu5zG3OvBc4mPWMxRfsRlmLMJXHhKnskd
         XlogvIqqN89DZWsj3zTzwLbaKtwuZeZT3025rzFwq6KkNX6JhlJoae38FAyi4mWVARxZ
         dq7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrc9UdjFrav6zkrxDOqQo07MLmaWBQNikrFjUVwO0oT8fb8ImIQjdiThi5cGh3lfLGun6+3nFQ+nMVf@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1x0ocKKv7r1XrlOzTcdOTwTlTGLQAqWAwnycVPSYqboBqJpjD
	Nb/xtnOz0rZIPM5QF7blROagKgap37XAFk5T33V7unwbds8YyC9XZVZt
X-Gm-Gg: AfdE7cnX+4Vhu2J1wq3Q8qC6c5wLKLvubmRmwPwvbhCBlTTRT0OoAZWR5P1589epvfJ
	0j93qyE0IqsheasA9pbvs2sF7oQoND2LNpmuR5pSnvHzmRwoGX/4wBKjefUSZZIaRHGt4NqaWtz
	em7gexJMO/pYnpTs8nCiWhmbFiQyJOTuVDyDBwXFbVXW2WzY3JgH7elCITi7ps87uxjpQgGvAIN
	HW2KCMZNrD6aahSQ4i4vMPgTp14HKp/73J98E7HOm8EV12ppHP+CWlkcdBdoRB9SPUBjSO4ZoNJ
	poN7J+L2y+71CFmrBr6knrwSyFlV/qoj07Nw1UC3b/IhJugNYhjTv3+CK6ere9rvPnfnQtmL8ZX
	9EU/+/GVFK4+/Ca3uHw0i+3HhLl32DJrxKMGx7rzRDjCzRwqgSFSxcvImhnPFuo3Ygc6hzw28RX
	5JoCMCflsMhM1QRtY3l870dxZDY7jUFWa9vw==
X-Received: by 2002:a05:6000:1866:b0:475:f0d1:eb56 with SMTP id ffacd0b85a97d-47f2dd0d63fmr3630999f8f.49.1783788505186;
        Sat, 11 Jul 2026 09:48:25 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d83bdsm69152875f8f.13.2026.07.11.09.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 09:48:24 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	--cc=linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH v4 0/6] phy: cpcap-usb: improve charger detection and export cable state
Date: Sat, 11 Jul 2026 19:47:48 +0300
Message-Id: <20260711164754.185565-1-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Motorola CPCAP USB PHY contains the hardware state machine used for
USB cable detection. Besides distinguishing USB peripheral and host
connections, it can also detect dedicated charging ports (DCP).

This series extends the CPCAP USB PHY driver to detect DCP connections
and export the detected cable state through the Extcon framework. It also
makes the idle UART mode optional, allowing the PHY to remain in its
default USB detection configuration unless UART support is explicitly
requested.

The series updates the Device Tree binding for the optional charger
detection interrupt and the optional "safe" pinctrl state. Corresponding
mapphone Device Tree entries are added to describe the charger detection
interrupt and enable the safe pinctrl state.

The charger detection interrupt is not currently used by the driver.
However, it is added to the binding and Device Tree because it describes
a hardware capability of the CPCAP USB PHY.

The series has been tested on Motorola Droid 4 hardware.

Changes in v4:
- make charger detection interrupt optional
- make driver functional without charger detection interrupt
- add bindings and Device Tree for 'safe' pinctrl mode
- use 'safe' pinctrl state before switching PHY modes

Changes in v3:
- Drop "phy: cpcap-usb: Prevent line glitches from triggering sysrq"
- Fix DT schema interrupts order
- Fix boot cable detection

Changes in v2:
- add chrg_det interrupt instead of replacing se1
- Fix remove() race by cancelling detect_work before hardware teardown
- Restore SysRq state on all error paths
- Introduce CPCAP_UNKNOWN initial mode
- Snapshot enable_uart module parameter

Ivaylo Dimitrov (6):
  dt-bindings: phy: motorola,cpcap-usb: add chrg_det interrupt
  dt-bindings: phy: motorola,cpcap-usb-phy: add optional safe pinctrl
    state
  phy: cpcap-usb: add DCP detection and make UART idle mode optional
  phy: cpcap-usb: add extcon support
  ARM: dts: ti: cpcap-mapphone: add charger detection interrupt for
    CPCAP USB PHY
  ARM: dts: ti: cpcap-mapphone: add USB safe pinctrl state

 .../bindings/phy/motorola,cpcap-usb-phy.yaml  |  13 +-
 .../dts/ti/omap/motorola-cpcap-mapphone.dtsi  |   9 +-
 .../dts/ti/omap/motorola-mapphone-common.dtsi |  19 +
 drivers/phy/motorola/phy-cpcap-usb.c          | 350 ++++++++++++++----
 4 files changed, 323 insertions(+), 68 deletions(-)

-- 
2.39.5

