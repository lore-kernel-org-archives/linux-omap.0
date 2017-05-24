From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 00/13] crypto: omap fixes / changes for 4.13
Date: Wed, 24 May 2017 10:35:21 +0300
Message-ID: <1495611334-15039-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-crypto-owner@vger.kernel.org>
Sender: linux-crypto-owner@vger.kernel.org
To: herbert@gondor.apana.org.au, lokeshvutla@ti.com, davem@davemloft.net, linux-crypto@vger.kernel.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

This series has a number of fixes towards 4.13 merge window (I don't
think we need to rush these as nobody has complained of any of the
issues so far), and the addition of AES GCM mode. Lokesh posted
the support patch for GCM quite a while back, I have addressed
the comments received back then as well as I could and done some
additional changes on top. The series also introduces a base
OMAP crypto support library for handling the various cases
of buffer alignment. This is now used for both AES/DES. Addition
of SHA to this is still pending as it requires certain things
to be done slightly differently (need a couple of new flags for
the API I believe.)

-Tero
